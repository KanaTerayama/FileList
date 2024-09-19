#' @title Create file list
#' @description \code{FileList} creates file list in any directory
#' @return csv file of file list in any directory
#' @import dplyr
#' @importFrom dplyr select
#' @export
#'
FileList<-function(path=gsub("/","\\\\",getwd()),tmstamp){
  tmstamp=c("ctime")
  dir.file<-list.files(path)
  dir.list<-dir.file[!grepl(".csv",dir.file)]
  dir.l<-length(dir.list)

  for (i in 1:dir.l) {
    dir.n<-dir.list[i]
    file.name<-list.files(paste(path,"\\",dir.n,sep=""))
    file.name<-file.name[!grepl(".csv",file.name)]
    file.DF<-file.info(paste(path,"\\",dir.n,"\\",file.name,sep=""))
    datetime<-dplyr::select(file.DF,tmstamp)
    datetime2<-strsplit(as.character(datetime[,1])," ")
    Tm.L<-length(datetime2)
    timelist=list()
    for (tm in 1:Tm.L) {
      time2<-as.character(datetime2[[tm]][2])
      time2<-strsplit(as.character(datetime2[[tm]][2]),"[.]")
      TDF<-data.frame(date=as.character(datetime2[[tm]][1]),
                      time=as.character(time2[[1]][1]))
      timelist[[tm]]<-TDF
    }
    timeDF=do.call(rbind,timelist)
    fileNDF<-data.frame(filename=file.name,
                        date=timeDF$date,
                        time=timeDF$time)
    write.csv(fileNDF,row.names = F,paste(path,"\\",dir.n,"\\",dir.n,".csv",sep=""))
  }
  print("csv files were created")
}
