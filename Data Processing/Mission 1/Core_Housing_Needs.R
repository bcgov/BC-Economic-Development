library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("46-10-0065-01", "eng")

df1_1 <- df1 |>
  filter(`Business characteristics` %in% c("Agriculture, forestry, fishing and hunting [11]",                                                  
                                           "Mining, quarrying, and oil and gas extraction [21]",                                               
                                           "Construction [23]" ,                                                                               
                                           "Manufacturing [31-33]" ,                                                                           
                                           "Wholesale trade [41]"  ,                                                                           
                                           "Retail trade [44-45]"  ,                                                                           
                                           "Transportation and warehousing [48-49]" ,                                                          
                                           "Information and cultural industries [51]" ,                                                        
                                           "Finance and insurance [52]"  ,                                                                     
                                           "Real estate and rental and leasing [53]" ,                                                         
                                           "Professional, scientific and technical services [54]" ,                                            
                                           "Administrative and support, waste management and remediation services [56]"    ,                   
                                           "Health care and social assistance [62]" ,                                                          
                                           "Arts, entertainment and recreation [71]" ,                                                         
                                           "Accommodation and food services [72]" ,                                                            
                                           "Other services (except public administration) [81]"),
         `Use of artificial intelligence (AI) by businesses or organizations in producing goods or delivering services over the last 12 months` %in% 
           c("Yes, business used AI for producing goods or delivering services over the last 12 months",
             "No, business or organization did not use AI for producing goods or delivering services over the last 12 months"))

df1_2 <- df1 |>
  filter(`Business characteristics` %in% c("Agriculture, forestry, fishing and hunting [11]",                                                  
                                           "Mining, quarrying, and oil and gas extraction [21]",                                               
                                           "Construction [23]" ,                                                                               
                                           "Manufacturing [31-33]" ,                                                                           
                                           "Wholesale trade [41]"  ,                                                                           
                                           "Retail trade [44-45]"  ,                                                                           
                                           "Transportation and warehousing [48-49]" ,                                                          
                                           "Information and cultural industries [51]" ,                                                        
                                           "Finance and insurance [52]"  ,                                                                     
                                           "Real estate and rental and leasing [53]" ,                                                         
                                           "Professional, scientific and technical services [54]" ,                                            
                                           "Administrative and support, waste management and remediation services [56]"    ,                   
                                           "Health care and social assistance [62]" ,                                                          
                                           "Arts, entertainment and recreation [71]" ,                                                         
                                           "Accommodation and food services [72]" ,                                                            
                                           "Other services (except public administration) [81]"),
         `Use of artificial intelligence (AI) by businesses or organizations in producing goods or delivering services over the last 12 months` %in% 
           c("Type of AI application used, machine learning",                                                                 
             "Type of AI application used, natural language processing",                                                      
             "Type of AI application used, virtual agents or chatbots",                                                       
             "Type of AI application used, speech or voice recognition using AI",                                             
             "Type of AI application used, recommendation systems using AI",                                                  
             "Type of AI application used, large language models",                                                            
             "Type of AI application used, text analytics using AI" ,                                                         
             "Type of AI application used, data analytics using AI" ,                                                         
             "Type of AI application used, neural network" ,                                                                  
             "Type of AI application used, augmented reality" ,                                                               
             "Type of AI application used, decision making systems based on AI" ,                                             
             "Type of AI application used, deep learning" ,                                                                   
             "Type of AI application used, image or pattern recognition" ,                                                    
             "Type of AI application used, machine or computer vision" ,                                                      
             "Type of AI application used, robotics process automation"  ,                                                    
             "Type of AI application used, biometrics " ,                                                                     
             "Type of AI application used, marketing automation using AI" ,                                                   
             "Type of AI application used, other"))


df1_1 <- df1 |>
  filter(`Business characteristics` %in% c("1 to 4 employees"                                                                                 
                                           "5 to 19 employees"                                                                                
                                           "20 to 99 employees"                                                                               
                                           "100 or more employees"),
         `Use of artificial intelligence (AI) by businesses or organizations in producing goods or delivering services over the last 12 months` %in% 
           c("Yes, business used AI for producing goods or delivering services over the last 12 months",
             "No, business or organization did not use AI for producing goods or delivering services over the last 12 months"))

df1 <- df1 |> 
  mutate(Tenure = `Tenure including first-time homebuyer and social and affordable housing status`,
         Statistics = `Core housing need statistics`) |>
  select(
    Year, GEO, Tenure, Statistics, UOM, VALUE
  )

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1, "C:/Users/MNAJI/StrongerBC-Project/Data/Core_Housing_Needs_1.csv", row.names = FALSE)
