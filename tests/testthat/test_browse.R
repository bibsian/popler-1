# test the browse_popler function 
library(testthat)

# Main utility functions ---------------------------------------------------------------------
context("browse(): Format Main Table()")

# does this function actually return character columns? 
test_that("Format Main Table", {
  
  expect_equal(is.character(popler:::factor_to_character(popler:::main_popler)[,2]),T)
  expect_equal(is.character(popler:::factor_to_character(popler:::main_popler)[,3]),T)
  expect_equal(is.character(popler:::factor_to_character(popler:::main_popler)[,4]),T)
  expect_equal(is.character(popler:::factor_to_character(popler:::main_popler)[,8]),T)
  expect_equal(is.character(popler:::factor_to_character(popler:::main_popler)[,9]),T)
  
})

context("browse(): Informational messages")

# Do informational messages provide the expected output?
test_that("Informational messages", {
  
  # Initial group_factors
  possibleargs <- tolower(c("lterid","proj_metadata_key","title","metalink","studytype","community","duration_years",
                            "study_site_key","datatype", "structured",
                            "species","taxonomy","kingdom","phylum","clss","ordr","family","genus"))
  
  # errors table
  expect_error(popler:::err_full_tab("pi",possibleargs))
  expect_error(popler:::err_full_tab("proj_metadata_fkey",possibleargs))
  expect_error(popler:::err_full_tab("rep_level_3",possibleargs))
  expect_error(popler:::err_full_tab("treatment",possibleargs))
  
})

context("browse(): Select by criteria")

# Select By Criteria function
test_that("Select by criteria", {
  
  # Data
  x <- popler:::factor_to_character(popler:::main_popler)
  
  # Test 1 
  subset_data <- popler:::select_by_criteria(x,substitute(kingdom == "Plantae"))
  expect_equal( unique(subset_data$kingdom), "Plantae")
  # Test 2
  subset_data <- popler:::select_by_criteria(x,substitute(lterid == "SEV"))
  expect_equal( unique(subset_data$lterid), "SEV")
  # Test 3
  subset_data <- popler:::select_by_criteria(x,substitute(genus == "Poa"))
  expect_equal( unique(subset_data$genus), "Poa")
  
  rm(list=c("x","subset_data"))
  
})

context("browse(): Keyword binary operator")

# Select By Criteria function
test_that("Keyword", {
  
  # Data
  x <- popler:::factor_to_character(popler:::main_popler)
  
  # Tests 
  expect_equal( x$title %=% c("ParAsiTe", "Npp", "hErb"),
                grepl(c("ParAsiTe|Npp|herb"), x$title, ignore.case = T))
  expect_equal( x$title %=% toupper(c("ParAsiTe", "Npp", "hErb")),
                grepl( toupper(c("ParAsiTe|Npp|herb")), x$title, ignore.case = T))
  expect_equal( x$authors %=% c("collins", "Lightfoot"),
                grepl( c("COLLINS|LIGHTfoot"), x$authors, ignore.case = T))
  
  rm(x)
  
})

# error functions ---------------------------------------------------------------------
context("browse(): error functions")

# does this function actually return character columns? 
test_that("Errors ", {
  
  main_t        <- popler:::factor_to_character(popler:::main_popler)
  names(main_t) <- tolower( names(main_t) )
  main_t        <- popler:::class_order_names(main_t)
  possible_arg  <- popler:::possibleargs
  
  # err_full_tab errors
  expect_error(popler:::err_full_tab( "lterids", names(main_t), possible_arg ))
  expect_error(popler:::err_full_tab( "gensus", names(main_t), possible_arg ))
  expect_error(popler:::err_full_tab( "tilte", names(main_t), possible_arg ))
  expect_error(popler:::err_full_tab( "specis", names(main_t), possible_arg ))
  
  # select criteria
  expect_error( popler:::select_by_criteria(main_t, substitute( lterid == "SEVa" )) )
  expect_error( popler:::select_by_criteria(main_t, substitute( lterids == "SEV" )) ) 
  expect_error( popler:::select_by_criteria(main_t, substitute( lterids == "SEVa" )) ) 
  
})


# browse function itself --------------------------------------------------
context("browse() function")

test_that("browse() function ", {
  
 
  # n of columns
  expect_equal(ncol( browse() ), 16 )
  expect_equal(ncol( browse(full_tbl = T) ), 59 )
  
  # functioning of "vars"
  expect_equal(names( browse(vars="lterid") ), c("proj_metadata_key", "lterid", "taxonomy") )
  expect_equal(names( browse(vars="lng_lter") ), c("proj_metadata_key", "lng_lter", "taxonomy") )
  
  #functioning error messages
  expect_error( browse(structured_type_3 == "stage" & datatype == "individual") )
  expect_error( browse(lterid == "SEVa") )
  expect_error( browse(lter == "SEV") )
  
})


# dictionary function --------------------------------------------------
context("dictionary() function")

test_that("dictionary() function ", {
  
  
  # n of variables in "informational message"
  expect_equal(nrow( dictionary() ), 22 )
  expect_equal(nrow( dictionary(full_tbl = T) ), 76 )
  
  # n of list elements
  expect_equal( length(dictionary("species")), 1)
  expect_equal( length(dictionary(c("lterid","lng_lter"))), 2)
  
  # class of list elements
  expect_equal( class(dictionary("species")[[1]]), "data.frame")
  expect_equal( class(dictionary("lterid")[[1]]), "character")
  
})



# summary_popler() function --------------------------------------------------
context("summary_popler() function")

test_that("summary_popler() function ", {
  
  
  # n of variables produced (this neeed to work)
  expect_equal(dim( summary_popler() ), c(1,1) )
  expect_equal(ncol( summary_popler(group_vars = "lterid",
                                    count_vars = "species") ), 
               2 )
  expect_equal(ncol( summary_popler(group_vars = "lterid",
                                    count_vars = c("species","order")) ), 
               3 )
  
  # column names produced
  expect_equal(names( summary_popler() ), "title_count" )
  expect_equal(names( summary_popler(count_vars = "lterid") ), "lterid_count" )
  expect_equal(names( summary_popler(count_vars = "class") ), "class_count" )


})

