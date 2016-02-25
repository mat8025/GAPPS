// simple spreadsheet.asl
//

setdebug(1)


    vp = cWi(@title,"SpreadSheet",@resize,0.1,0.1,0.6,0.7,0)

    sWi(vp,@resize,0.1,0.1,0.7,0.5,@clip,0.1,0.1,0.7,0.9,@redraw)

    sWi(vp,@pixmapon,@drawoff,@save,@bhue,"white")


    gwo3=createGWOB(vp,@sheet,@name,"Sums",@color,"green",@resize,0.1,0.15,0.95,0.78)

 // does value remain or reset by menu?

    sWo(gwo3,@setrowscols,12,12,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"SSWO")
    sWo(gwo3,@bhue,"cyan",@clipbhue,"skyblue",@redraw)



    wkeep(vp)
   