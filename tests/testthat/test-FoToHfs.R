context("Data transfer from FO to HFS")

test_that("Correct Fo.meta.data input argument",{
  expect_error(FoToHfs(), "meta.data argument is missing")
  
  expect_error(FoToHfs(1), "meta.data is not an instance of data.frame class")
})
