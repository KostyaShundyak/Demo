require(uuid)

context("Import HFS data to memory")

test_that("Correct 'hfsFile' input argument",{
  
  expect_error(hfsToInMemory(), "hfsFile argument is missing")
  
  expect_error(hfsToInMemory(1), "hfsFile is not an instance of character class")
  
  expect_error(hfsToInMemory(UUIDgenerate()), "hfsFile argument does not point to the existing file in data repository")

  #MAYBE: add test that identical object is retrieved after save
})