context("Make URL BOE")

test_that("Correct 'SeriesCodes' input argument",{
  
  expect_error(make.url.BOE(,as.Date("31/Mar/1993",format = "%d/%b/%Y"), as.Date("06/Aug/2015",format = "%d/%b/%Y")),
               "SeriesCodes argument is missing")
  
  expect_error(make.url.BOE(1,as.Date("31/Mar/1993",format = "%d/%b/%Y"), as.Date("06/Aug/2015",format = "%d/%b/%Y")),
               "SeriesCodes is not an instance of character class")
})

test_that("Correct 'Datefrom' input argument",{
  
  expect_error(make.url.BOE("RPQTFHD",,as.Date("06/Aug/2015",format = "%d/%b/%Y")),
               "Datefrom argument is missing")
  
  expect_error(make.url.BOE("RPQTFHD","31/Mar/1993", as.Date("06/Aug/2015",format = "%d/%b/%Y")),
               "Datefrom is not an instance of Date class")
})

test_that("Correct 'Dateto' input argument",{
  
  expect_error(make.url.BOE("RPQTFHD",as.Date("31/Mar/1993",format = "%d/%b/%Y"),),
               "Dateto argument is missing")
  
  expect_error(make.url.BOE("RPQTFHD",as.Date("31/Mar/1993",format = "%d/%b/%Y"), "06/Aug/2015"),
               "Dateto is not an instance of Date class")
  
})

test_that("Function output matches mock data example",{

  #MAYBE: put mock data into a separate database
    
  expect_equal(make.url.BOE("RPQTFHD",as.Date("31/Mar/1993",format = "%d/%b/%Y"), as.Date("06/Aug/2015",format = "%d/%b/%Y")), 
               "http://www.bankofengland.co.uk/boeapps/iadb/fromshowcolumns.asp?csv.x=yes&Datefrom=31/Mar/1993&Dateto=06/Aug/2015&SeriesCodes=RPQTFHD&CSVF=TN&UsingCodes=Y&VPD=Y&VFD=N")
})