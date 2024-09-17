#' @title Create file list
#' @description \code{FileList} create a file list of each directory.
#' @return csv file of file list in directory.
#' @export
#'
FileList<-function(path){
  dir.file<-list.files(path)
  dir.list<-dir.file[!grepl(".csv",dir.file)]
  dir.l<-length(dir.list)

  for (i in 1:dir.l) {
    dir.n<-dir.list[i]
    file.name<-list.files(paste(set.dir,"\\",dir.n,sep=""))
    file.name<-file.name[!grepl(".csv",file.name)]
    file.DF<-file.info(paste(set.dir,"\\",dir.n,"\\",file.name,sep=""))
    datetime<-as.character(file.DF$ctime)
    datetime2<-strsplit(datetime," ")
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
}
