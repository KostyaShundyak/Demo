context("Data transfer from FO to HFS")

test_that("Correct FO input argument",{
  expect_error(FoToHfs(,as.Date("06/Aug/2015",format = "%d/%b/%Y"),data.frame()),
               "FO argument is missing")
  
  expect_error(FoToHfs(1,as.Date("06/Aug/2015",format = "%d/%b/%Y"),data.frame()),
               "FO argument does not correspond to a supported FO system")
})

test_that("Correct Dateto input argument",{
  expect_error(FoToHfs("BoE",,data.frame()), "Dateto argument is missing")
  
  expect_error(FoToHfs("BoE","06/Aug/2015",data.frame()), "Dateto is not an instance of Date class")
})

test_that("Correct Fo.meta.data input argument",{
  expect_error(FoToHfs("BoE",as.Date("06/Aug/2015",format = "%d/%b/%Y"),), 
               "Fo.meta.data argument is missing")
  
  expect_error(FoToHfs("BoE",as.Date("06/Aug/2015",format = "%d/%b/%Y"),1), 
               "Fo.meta.data is not an instance of data.frame class")
})
