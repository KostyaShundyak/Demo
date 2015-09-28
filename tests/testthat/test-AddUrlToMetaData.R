context("Adding file path to meta data")

test_that("Correct FO input argument",{
  expect_error(AddUrlToMetaData(,as.Date("06/Aug/2015",format = "%d/%b/%Y"),data.frame()),
               "FO argument is missing")
  
  expect_error(AddUrlToMetaData(1,as.Date("06/Aug/2015",format = "%d/%b/%Y"),data.frame()),
               "FO argument does not correspond to a supported FO system")
})

test_that("Correct Dateto input argument",{
  expect_error(AddUrlToMetaData("BoE",,data.frame()), "Dateto argument is missing")
  
  expect_error(AddUrlToMetaData("BoE","06/Aug/2015",data.frame()), "Dateto is not an instance of Date class")
})

test_that("Correct meta.data input argument",{
  expect_error(AddUrlToMetaData("BoE",as.Date("06/Aug/2015",format = "%d/%b/%Y"),), 
               "meta.data argument is missing")
  
  expect_error(AddUrlToMetaData("BoE",as.Date("06/Aug/2015",format = "%d/%b/%Y"),1), 
               "meta.data is not an instance of data.frame class")
})
