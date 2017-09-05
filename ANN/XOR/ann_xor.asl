///
/// asl version of ann - test vector matrix ops




DB = 1

BIAS_LIMIT = 1000.0

proc prv (vec, name)
{
:n=cab(&vec)
#<<"vec $(typeof(&vec)) $n\n"
<<"$name "
for (:i=0;i<n;i++) <<"$vec[i] " ; <<"\n"
}

proc limit_bias (float bias)
{
  float new_bias;

  if (bias > 1000.0)
      new_bias = BIAS_LIMIT;
  else if (bias < -BIAS_LIMIT)
      new_bias = -BIAS_LIMIT;
  else
    new_bias = bias;
  return new_bias;
}

proc hyperactiv (hya)
{
  hyae = (2.0 / (1.0 + exp (-2.0 * hya)) - 1.0)
  <<"$cproc %v$hya $hyae\n"

 return  hyae
}

proc diffhyper (hya)
{
#<<"$cproc %v$hya \n"
  return ((1.0 + hya) * (1.0 - hya))
}

proc pnet(i)
{
# act
<<"\n$i\n"
<<"act in "
    :j=0
    for (:i=0;i<nin;i++) <<"$nact[j++] "
<<"\nact hidden "
    for (:i=0;i<nh1;i++) <<"$nact[j++] "
<<"\nact out "
    for (:i=0;i<nout;i++) <<"$nact[j++] "

<<"\n"
# delta error signal
    j = nin+nh1
<<"\ndelta out "
    for (:i=0;i<nout;i++) <<"$ndelta[j++] "
    j = nin
<<"\ndelta  hidden "
    for (:i=0;i<nh1;i++) <<"$ndelta[j++] "

<<"\n"


<<"\n"
     j = 0
#<<"\ntheta in "
#    for (:i=0;i<nin;i++) <<"$ntheta[j++] "
    j = nin
<<"\ntheta  hidden "
    for (:i=0;i<nh1;i++) <<"$ntheta[j++] "
<<"\ntheta out "
    for (:i=0;i<nout;i++) <<"$ntheta[j++] "
<<"\n"


# wts
<<"\nhidden wts "
    :n = nh1*nin
    for (:i=0;i<n;i++) <<"$h1wts[i] "
<<"\nout wts "
    n = nh1*nout
    for (:i=0;i<n;i++) <<"$outwts[i] "
<<"\n"
}

proc fsweep(int patn)
{
  k = 0
  ni = nin
  ik = patn * nin 

 // scale the data and activate the input nodes
  for (:j = 0 ; j < nin ; j++) {
      inva  = scf * data[ik]
      ae = hyperactiv(inva)
      nact[j] = ae
      if (DB)   <<"$data[ik] %v$inva %v$nact[j] %v$j  \n";
      ik++
  }

if (DB)  <<"\n"

# hidden 1 

  for (:j = 0 ; j < nh1; j++) {

  a = 0.0

  for (ip = 0 ; ip < nin; ip++) {

  a += nact[ip] * h1wts[k++]

#<<"%v$i %v$k %v$a $ip\n"
  }

  if (theta > 0.0) {
 if (DB) <<"adding theta_bias %v$theta $ntheta[ni] \n"
   a += ntheta[ni]  
  }

  nact[ni] = hyperactiv(a)

  if (DB) <<"hidd $ni $nact[ni] $a "
  ni++

  }

 if (DB)<<"\n"

# further hidden layers

# output

  hn = nh1
  k = 0

  for (j=0;j<nout;j++) {

  a = 0.0
  i = hn

  for (ip = 0 ; ip < nh1; ip++) {

  if (DB)<<"$i $nact[i] $k $outwts[k] \n"

  a += nact[i++] * outwts[k++]

#<<"%v$i %v$k $a\n"
  }

  if (theta > 0.0) {
if (DB) <<"adding theta_bias %v$theta $ntheta[ni] \n"
   a += ntheta[ni]  
  }

  nact[ni] = hyperactiv(a)

  if (DB) <<"out $ni $nact[ni] "
  ni++
  }

  if (DB)<<"\n"
}

proc output_error(i)
{
  ss= 0.0
# index to first output cell
  ni = nin + nh1
# index to truth - required output
  ti = i * nout
# get error and deltas

  for (:j = 0; j < nout; j++) {
  err = truth[ti++] - nact[ni]
  serr = err^2

  if (DB)  <<"oe $j $err $serr\n"
  ss += serr
# get differential of output act
# wls
  diff = diffhyper(nact[ni])
  ndelta[ni] = diff * err
  ni++
  }   

# make the change to the output wts
# delta (diff of output act * error)
# change on wts delta * eta * activity of connected node
# change = node[j].delta * ann->net.eta * node[conn[i].node].activity;

  ni = nin + nh1
  owi = 0
  de = 0.0
  for (j = 0 ; j < nout ; j++) {
    delta = ndelta[ni]
    hi = nin
    de = delta * eta
    for (:k = 0; k < nh1; k++) {
    change = de * nact[hi]
    outwts_old[owi] = outwts[owi]
    outwts[owi++] += change    
    hi++   
    }

	      if (theta > 0.0)
		{
                      del_ch = de + theta * ntheta_wc[ni];
                if (DB) <<"theta %v$ni %v$del_ch \n"
#		      ntheta[ni] += del_ch;
			  // bug applying del_ch to whole vector
		      ntheta[ni] = ntheta[ni] + del_ch
		      ntheta[ni] = limit_bias(ntheta[ni])
                      ntheta_wc[ni] = del_ch
            	}
            ni++
  }
  return ss
}


// just one hidden for now
proc hidden_error(i)
{
  ni = nin
  nniul = nout
  nnill = nin
  // for all nodes in this hidden layer

  for (:j = 0 ; j < nh1 ; j++) {
      act = nact[ni]
      dw = 0.0;
      owi = 0
      for (:kk = 0; kk < nniul ; kk++)
	{
// which node 
          k = nin + nh1 + kk
// delta signal - delta * wt from lower to upper node 
// sff -network all nodes connected from one layer to next
// delta signal from all upper nodes * oldwt sum to give backprop error
	    dw += ndelta[k] * outwts_old[owi]
	    // dw sums the error signal from the connected upper nodes
	    // this steps by number in hidden layer
            owi += nh1
	}
      ndelta[ni] =  diffhyper(act) * dw;
//    Calculate change in weights between hidden and  lower nodes  in lower layer
      i = 0              
      hwi = 0
      dc = ndelta[ni] * eta

      for (:ii = 0; ii < nnill ; ii++)
	{
         change = dc * nact[i];
	// momentum         hwc = (change + ann->net.alpha * node[j].conn[wc].wt_ch);
        //  old wt is kept for next hidden layer error signal calc ?
           h1wts_old[hwi] = h1wts[hwi]
           h1wts[hwi] += change
           hwi += nin
           i++
        }

      if (theta > 0.0)
	{
	      ntheta_wc[ni] = dc + theta * ntheta_wc[ni];
#	      ntheta[ni] += ntheta_wc[ni];
	      ntheta[ni] = ntheta[ni] + ntheta_wc[ni];
                if (DB) <<"hidden theta %v$ni %v$dc $ntheta[ni] $ntheta_wc[ni]\n"
              ntheta[ni] = limit_bias(ntheta[ni])
	      // limit wt change ?
	}
       ni++
  }
}


# data

float data[] = {1.,1,1,-1.0,-1.0,1,-1.0,-1.0}
float truth[] = {0,1,1,0}

# learning parameters

eta = 0.01
alpha = 0.9
theta = 0.9

prv(&data,"data")
prv(&truth,"truth")

nreport = 10
nin = 2
nout = 1
nh1 = 2
scf = 1.0
npats = 4
rms = 0.0
nsweeps = 1
loop = 0

cla = 1
na = get_argc()
generic arg

  while (cla <= na) {
    arg = _clarg[cla];
    cla++;
   if (arg @= "nsweeps") nsweeps = _clarg[cla++];
   if (arg @= "DB") DB = _clarg[cla++];
   if (arg @= "eta") eta = _clarg[cla++];
   if (arg @= "alpha") alpha = _clarg[cla++];
   if (arg @= "theta") theta = _clarg[cla++];
   if (arg @= "nh1") nh1 = _clarg[cla++];
   if (arg @= "loop") loop = 1
  }
   if (nsweeps <= 0) nsweeps =1

<<"%v$nsweeps %v$eta %v$theta %v$alpha %v$nh1\n"

# net node activation
     // actually will have to have all wts in one vector to allow indexing for more than one hidden layer
     // ditto for old_wts

nnodes = nh1+nout+nin

   best_rms = 1.0
   trial = 1

float ntheta[nnodes+]
float ntheta_wc[nnodes+]

name_debug("SI",0)

   while (1) {

       v_frand(&h1wts,nh1*nin)
       h1wts += -0.50
       prv(&h1wts,"h1wts")
       v_frand(&outwts,nout*nh1)
       outwts += -0.50
       prv(&outwts,"outwts")

	 outwts_old = outwts * 1.0
	 h1wts_old = h1wts * 1.0
	#prv(&h1wts_old,"h1wts_old")

        v_set(&nact,0.0,0.0,nnodes)
	prv(&nact,"nact")
// only need to keep deltas for non-input layers but easier to keep track by having same dimensions as act
	v_set(&ndelta,0.0,0.0,nnodes)
	prv(&ndelta,"ndelta")
  // self -bias thresholds
	v_set(&ntheta,0.0,0.0,nnodes)
  // only need theta for hidden and output : input just used for activation
  // although conceivably adaptively adjusting input thresholds might be useful

	v_frand(&ntheta[nin],nh1+nout)
	ntheta += -0.5

	v_set(&ntheta_wc,0.0,0.0,nnodes)
	# clear input theta
		 for(i=0;i<nin;i++) ntheta[i] = 0.0
				      prv(&ntheta,"ntheta")

	<<"%v$best_rms \n"
	
	 for (nsi = 0 ; nsi < nsweeps ; nsi++) {
	
	  rms = 0.0
	
	  for (pi=0; pi<npats; pi++)  {
	  fsweep(pi)
	  rms += output_error(pi)
	  hidden_error(pi)
	#  pnet(pi)
	  }
	
	  rms = rms/(npats * nout)
	  rms = sqrt(rms)
	
	   if (!(nsi % nreport))  { <<"%v$nsi %v$rms \n" ; }
	
	   }
	
	
	  rms = 0.0
	  for (pi=0; pi<npats; pi++)  {
	   fsweep(pi)
	   rms += output_error(pi)
	   hidden_error(pi)
	   pnet(pi)
	  }
	
	 rms = rms/(npats * nout)
	 rms = sqrt(rms)
	
	   if (rms < best_rms ) best_rms = rms
	<<"$trial $rms $best_rms \n"
	   trial++
	
	 if (rms < 0.2) { <<"success %v$trial \n" ; break ;}
	 if (!loop) break
   }
	
exit_si()
