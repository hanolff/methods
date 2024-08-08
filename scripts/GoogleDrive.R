# the best way to read a file depends on the type of file
# if the file is very big (more than 10 million cells (rowsxcolumns) than store the data in a .csv file on your google drive

rm(list = ls())
# The library GoogleDrive allows to read from files on a personal or shared google drive, including authentication. 
library(renv)
renv::restore()  # restore required libraries for this project
library("googledrive")
library("tidyverse")

# Authorize (authenticate) tidyverse access to your Google Drive 
googledrive::drive_auth()
# at the first time, respond with 1 for a new authentication process and go to your browser, 
# choose your google account, 
# and check the box "See, edit, create, and delete all of your Google Drive files"
# once you have authenticated a partical account (indicated by the email adress) you can select this direct next time in the script. This is because a  file named .httr-oauth containing the authentication is written in your working directory 
googledrive::drive_auth(email="h.olff@rug.nl")

# Download a CSV file using the file ID:
# Use the drive_download() function to download the file from Google Drive. You need to know the file ID 
# of the CSV file you want to download. The file ID is a unique identifier for the file in Google Drive,
# which you can find in the file's URL.
# This file ID can be found by 
# 1) opening the google drive at drive.google.com
# 2) navigating to the .csv file, right-click on the file and select "copy link" 
# 3) pasting the link in your R script  and extract the ID
# for example, of the link
# https://drive.google.com/file/d/1_k4LBOo_yJlzQ_yYlLtzCY3xRS6_0LkG/view?usp=drive_link
# the ID of the file is 1_k4LBOo_yJlzQ_yYlLtzCY3xRS6_0LkG

# define the file  ID of the CSV file to google drive, 
# it may be easy to use the same name as your file on google drive with _id added to it
# download and reading of google drive file EVI2001_2023.csv with file ID 13DVqqDp_SpwshIPk3YIIh6iagkjTUF7B
file_id<- "16kDi6DHH2moJ6Y7_APMk3cU64nuy_04S"  # define ID
file<-googledrive::drive_get(googledrive::as_id(file_id)) # get metadata
download_link<-drive_download(file, overwrite = TRUE)
EVIdata<-read_csv(download_link$local_path)
