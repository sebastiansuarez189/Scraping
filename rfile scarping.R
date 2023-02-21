library(rvest)

paragraph <- read_html("https://informnapalm.org/en/up-to-15-of-drivers-in-ukraine-unknowingly-spy-for-russia-by-using-russian-apps/") %>%
  html_nodes("p") %>%
  html_text()

save(paragraph, file="paragraphs.RData")

url_list <- c("https://informnapalm.org/en/up-to-15-of-drivers-in-ukraine-unknowingly-spy-for-russia-by-using-russian-apps/", 
              "https://syriaaccountability.org/accountability-for-russian-crimes-in-syria-and-ukraine/", 
              "https://airwars.org/conflict/russian-military-in-syria/")

scraper <- function(url) {
  read_html(url) %>% #This reads the html of the url provided
    html_nodes("p") %>%  #This selects the specific node you're looking to scrape
    html_text() %>% #This then scrapes the text from that note
    enframe("id", "text") #This puts it into a data frame with one column being id (or th
}

multiparagraph <- lapply(url_list, scraper)

multi_df <- as.data.frame(do.call(rbind, multiparagraph))

save(multi_df, file="multiple_url_paragraphs.RData")
