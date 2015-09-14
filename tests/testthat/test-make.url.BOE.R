context("Make URL BOE")

test_that("Correct 'Datefrom' input argument",{
  
  expect_error(make.url.BOE(,as.Date("31/Mar/1993",format = "%d/%b/%Y"), as.Date("06/Aug/2015",format = "%d/%b/%Y")),
               "SeriesCodes argument is missing")
  
  expect_error(make.url.BOE("RPQTFHD",,as.Date("06/Aug/2015",format = "%d/%b/%Y")),
               "Datefrom argument is missing")
  
  expect_error(make.url.BOE("RPQTFHD",as.Date("31/Mar/1993",format = "%d/%b/%Y"),),
               "Dateto argument is missing")
  
  expect_error(make.url.BOE(RPQTFHD,as.Date("31/Mar/1993",format = "%d/%b/%Y"), as.Date("06/Aug/2015",format = "%d/%b/%Y")),
               "SeriesCodes is not an instance of character class")
  
  expect_error(make.url.BOE("RPQTFHD","31/Mar/1993", as.Date("06/Aug/2015",format = "%d/%b/%Y")),
               "Datefrom is not an instance of Date class")
  
  expect_error(make.url.BOE("RPQTFHD",as.Date("31/Mar/1993",format = "%d/%b/%Y"), "06/Aug/2015"),
               "Dateto is not an instance of Date class")
  
  expect_equal(make.url.BOE("RPQTFHD",as.Date("31/Mar/1993",format = "%d/%b/%Y"), as.Date("06/Aug/2015",format = "%d/%b/%Y")), 
               "http://www.bankofengland.co.uk/boeapps/iadb/fromshowcolumns.asp?csv.x=yes&Datefrom=1993-03-31&Dateto=2015-08-06&SeriesCodes=RPQTFHD&CSVF=TN&UsingCodes=Y&VPD=Y&VFD=N")
})