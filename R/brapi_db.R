#' @title
#' brapi_db
#'
#' @description
#' A white list of known BrAPI compliant databases.
#'
#' @details
#' Extended the function call with $database_name. White listed values for
#' database_name are: apiary, bms_test, cassavabase, cropontology, eu_sol,
#' genesys, germinate, icrisat_prod, imagebreed, mgis, musabase, ricebase,
#' snpseek, sweetpotatobase, terraref, testserver, t3s, tto, ttw, yambase.
#'
#' @return An BrAPI compliant database connection object of class brapi_db.
#'
#' @author brapir generator package
#'
#' @family brapiutils
#'
#' @importFrom magrittr `%>%`
#'
#' @export
brapi_db <- function() {
  apiary <- as.brapi_db(secure = TRUE,
                        protocol = "https://",
                        db = "private-anon-3d3307a632-brapi.apiary-mock.com",
                        port = 80,
                        multicrop = FALSE,
                        commoncropname = "wheat",
                        bms = FALSE)
  bms_test <- as.brapi_db(secure = TRUE,
                          protocol = "https://",
                          db = "brapi.bms-uat-test.net",
                          port = 443,
                          apipath = "bmsapi",
                          multicrop = TRUE,
                          commoncropname = "",
                          user = "",
                          password = "",
                          bms = TRUE)
  cassavabase <- as.brapi_db(secure = TRUE,
                             protocol = "https://",
                             db = "cassavabase.org",
                             port = 80,
                             multicrop = FALSE,
                             commoncropname = "Cassava",
                             bms = FALSE)
  cropontology  <- as.brapi_db(secure = FALSE,
                               protocol = "http://",
                               db = "cropontology.org",
                               port = 80,
                               multicrop = FALSE,
                               commoncropname = "",
                               bms = FALSE)
  eu_sol <- as.brapi_db(secure = TRUE,
                        protocol = "https://",
                        db = "www.eu-sol.wur.nl",
                        apipath = "webapi",
                        multicrop = TRUE,
                        commoncropname = "tomato",
                        bms = FALSE)
  genesys <- as.brapi_db(secure = TRUE,
                         protocol = "https://",
                         db = "www.genesys-pgr.org",
                         apipath = "",
                         multicrop = FALSE,
                         commoncropname = "pigeonpea",
                         bms = FALSE)
  germinate <- as.brapi_db(secure = TRUE,
                           protocol = "https://",
                           db = "ics.hutton.ac.uk",
                           port = 80,
                           apipath = "germinate-demo/cactuar-devel",
                           multicrop = FALSE,
                           commoncropname = "Cactuar",
                           bms = FALSE)
  icrisat_prod <- as.brapi_db(secure = FALSE,
                              protocol = "http://",
                              db = "bms.icrisat.org",
                              port = 48080,
                              apipath = "bmsapi",
                              multicrop = TRUE,
                              commoncropname = "chickpea",
                              user = "",
                              password = "",
                              granttype = "password",
                              clientid = "brapirv1",
                              bms = TRUE)
  imagebreed <- as.brapi_db(secure = TRUE,
                            protocol = "https://",
                            db = "imagebreed.org",
                            port = 443,
                            apipath = NULL,
                            multicrop = FALSE,
                            commoncropname = "",
                            user = "",
                            password = "",
                            token = "",
                            granttype = "password",
                            clientid = "brapirv1",
                            bms = FALSE)
  mgis <- as.brapi_db(secure = TRUE,
                      protocol = "https://",
                      db = "www.crop-diversity.org",
                      port = 80,
                      apipath = "mgis",
                      multicrop = FALSE,
                      commoncropname = "musa",
                      user = "",
                      password = "",
                      bms = FALSE)
  musabase <- as.brapi_db(secure = TRUE,
                          protocol = "https://",
                          db = "musabase.org",
                          port = 80,
                          multicrop = FALSE,
                          commoncropname = "musa",
                          bms = FALSE)
  ricebase <- as.brapi_db(secure = TRUE,
                          protocol = "https://",
                          db = "ricebase.org",
                          port = 80,
                          multicrop = FALSE,
                          commoncropname = "rice",
                          bms = FALSE)
  snpseek <- as.brapi_db(secure = FALSE,
                         protocol = "http://",
                         db = "snp-seek.irri.org",
                         port = 80,
                         apipath = "ws",
                         user = "snpseek-user",
                         password = "snpseek-user-pass",
                         multicrop = FALSE,
                         commoncropname = "rice",
                         token = "",
                         bms = FALSE)
  sweetpotatobase <- as.brapi_db(secure = TRUE,
                                 protocol = "https://",
                                 db = "sweetpotatobase.org",
                                 port = 80,
                                 multicrop = FALSE,
                                 commoncropname = "SweetPotato",
                                 bms = FALSE)
  terraref <- as.brapi_db(secure = TRUE,
                          protocol = "https://",
                          db = "brapi.workbench.terraref.org",
                          port = 80,
                          multicrop = TRUE,
                          commoncropname = c("wheat", "sorghum"),
                          bms = FALSE)
  testserver <- as.brapi_db(secure = TRUE,
                            protocol = "https://",
                            db = "test-server.brapi.org",
                            port = 80,
                            multicrop = FALSE,
                            commoncropname = "crop1",
                            bms = FALSE)
  t3s <- as.brapi_db(secure = TRUE,
                     protocol = "https://",
                     db = "triticeaetoolbox.org",
                     port = 443,
                     apipath = "wheat",
                     multicrop = TRUE,
                     commoncropname = "wheat",
                     user = "",
                     password = "",
                     bms = FALSE)
  tto <- as.brapi_db(secure = TRUE,
                     protocol = "https://",
                     db = "triticeaetoolbox.org",
                     port = 80,
                     apipath = "",
                     multicrop = TRUE,
                     commoncropname = "oat",
                     user = "",
                     password = "",
                     bms = FALSE)
  ttw <- as.brapi_db(secure = TRUE,
                     protocol = "https://",
                     db = "triticeaetoolbox.org",
                     port = 80,
                     apipath = "",
                     multicrop = TRUE,
                     commoncropname = "wheat",
                     user = "",
                     password = "",
                     bms = FALSE)
  yambase <- as.brapi_db(secure = TRUE,
                         protocol = "https://",
                         db = "yambase.org",
                         port = 80,
                         multicrop = FALSE,
                         commoncropname = "yam",
                         bms = FALSE)
  out <- list(apiary = apiary,
              bms_test = bms_test,
              cassavabase = cassavabase,
              cropontology = cropontology,
              eu_sol = eu_sol,
              genesys = genesys,
              germinate_test = germinate,
              icrisat_prod = icrisat_prod,
              imagebreed = imagebreed,
              mgis = mgis,
              musabase = musabase,
              ricebase = ricebase,
              snpseek = snpseek,
              sweetpotatobase = sweetpotatobase,
              terraref = terraref,
              testserver = testserver,
              t3s = t3s,
              tto = tto,
              ttw = ttw,
              yambase = yambase)
  class(out) <- c(class(out), "brapi_db", "brapi", "brapi_con")
  return(out)
}
