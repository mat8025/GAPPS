///
/// @vers supdate.asl 1.1 H/H Tue Dec 18 04:07:52 2018
///



//   so find or insert @vers line which will look like
//   a three line comment header at top of the file
//   like
// ---------------------------------
///
/// @vers 'name'.asl maj.min majele/minele date time
///
// ---------------------------------

//
//




// if script found
// then  read current vers and  bump number and update date
// if no @vers line -- then prepend the vers header lines

srcfile = _clarg[1];

if (srcfile @= "") {
<<"no script file entered\n"
  exit();
}

sz= fexist(srcfile,RW_,0);

<<" RW sz $sz \n"

if (sz == -1) {
<<"can't find script file $srcfile\n"
  exit();

}

file= fexist(srcfile,ISFILE_,0);

<<" FILE $file \n"

dir= fexist(srcfile,ISDIR_,0);

<<" DIR $dir \n"


fs = fstat(srcfile,"mode");


<<"mode $fs %o $fs\n"

inode = fstat(srcfile,"inode");


<<"inode %o $inode\n"



ct = fstat(srcfile,"ctime");


<<"ctime $ct\n"

mt = fstat(srcfile,"mdate");


<<"mtime $mt\n"


at = fstat(srcfile,"adate");


<<"atime $at\n"

td = fstat(srcfile,"cdate");

<<"cdate $td\n"


td = ctime(ct);

<<"ctime $td\n"

issymlink = fstat(srcfile,"issymlink");

<<"symlink? $issymlink\n"

isdir = fstat(srcfile,"isdir");

<<"%V $isdir ?\n"

/{
S_IFMT     0170000   bit mask for the file type bit field

           S_IFSOCK   0140000   socket
           S_IFLNK    0120000   symbolic link
           S_IFREG    0100000   regular file
           S_IFBLK    0060000   block device
           S_IFDIR    0040000   directory
           S_IFCHR    0020000   character device
           S_IFIFO    0010000   FIFO


           S_ISUID     04000   set-user-ID bit
           S_ISGID     02000   set-group-ID bit (see below)
           S_ISVTX     01000   sticky bit (see below)

           S_IRWXU     00700   owner has read, write, and execute permission
           S_IRUSR     00400   owner has read permission
           S_IWUSR     00200   owner has write permission
           S_IXUSR     00100   owner has execute permission

           S_IRWXG     00070   group has read, write, and execute permission

           S_IRGRP     00040   group has read permission
           S_IWGRP     00020   group has write permission
           S_IXGRP     00010   group has execute permission

           S_IRWXO     00007   others  (not  in group) have read, write, and
                               execute permission
           S_IROTH     00004   others have read permission
           S_IWOTH     00002   others have write permission
           S_IXOTH     00001   others have execute permission




/}