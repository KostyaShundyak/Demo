context("Generate FO meta data")

test_that("Correct meta data output",{
    
    #formal identity testing
    tmp <- data.frame(SeriesName = c("RPQTFHD","RPQB7YW"), DateFrom = c("31/Mar/1993","31/Mar/1993"),stringsAsFactors = FALSE)
    expect_identical(generateFoMetaData(), tmp, "Identity testing failed") 
})
