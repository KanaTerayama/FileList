#' @title Create file list
#' @description \code{FileList} creates file list in any directory
#' @return csv file of file list in any directory
#' @import dplyr
#' @importFrom dplyr select
#' @export
#'
FileList<-function(path,tmstamp){
  tmstamp=tmstamp
  dir.file<-list.files(path)
  dir.list<-dir.file[!grepl(".csv",dir.file)]
  dir.l<-length(dir.list)

  for (i in 1:dir.l) {
    dir.n<-dir.list[i]
    file.name<-list.files(paste(path,"\\",dir.n,sep=""))
    file.name<-file.name[!grepl(".csv",file.name)]
    file.DF<-file.info(paste(path,"\\",dir.n,"\\",file.name,sep=""))%>%
      rename(date=tmstamp)
    fileNDF<-data.frame(filename=file.name,
                        date=file.DF$date)
    write.csv(fileNDF,row.names = F,paste(path,"\\",dir.n,"\\",dir.n,".csv",sep=""))
  }
  print("csv files were created")
}
