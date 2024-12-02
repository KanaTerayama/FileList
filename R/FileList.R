#' @title Create file list
#' @description \code{FileList} creates file list in any directory
#' @param path character: the path to the directories containing folders of data
#' @param tmstamp character: date field to return, which should be the date for
#' which the data was taken; either "mtime" (date
#' modified), "ctime" (last status change), or "atime" (last access) -- this
#' value should usually be "mtime"
#' @return csv file of file list in the input directory
#' @export
#'
FileList<-function(path,tmstamp){
  tmstamp=tmstamp
  dir.file<-list.files(path)
  dir.list<-dir.file[!grepl(".csv",dir.file)]
  dir.l<-length(dir.list)

  for (i in 1:dir.l) {
    dir.n<-dir.list[i]
    file.name<-list.files(file.path(path,dir.n))
    file.name<-file.name[!grepl(".csv",file.name)]
    file.DF<-file.info(file.path(path,dir.n,file.name))
    file.DF.dateFieldIndex <- which(names(file.DF) == tmstamp)
    names(file.DF)[file.DF.dateFieldIndex] <- "date"
    fileNDF<-data.frame(filename=file.name,
                        date=file.DF$date)
    write.csv(fileNDF,row.names = F, paste0(file.path(path,dir.n),".csv"))
  }
  print("csv files were created")
}
