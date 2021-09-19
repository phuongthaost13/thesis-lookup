# 15092021
# By Phương Thảo
# Data đề tài tốt nghiệp khoa nông học, sử dụng để tạo
# shiny embeded lên trang web

#library(stringr)
library(dplyr)

k43 <- tibble(read.csv('data/k43.csv', encoding = 'UTF-8'))
k42 <- tibble(read.csv('data/k42.csv', encoding = 'UTF-8'))

dt <- rbind(k42, k43) %>% 
  rename(time = colnames(k43[,1])) %>% 
  arrange((time)) %>% 
  slice(-(1:1)) %>% 
  select(-time) %>% 
  mutate(id = row_number(), .before=1) %>% 
  select(-last_col()) %>% 
  mutate(email = 'Liên hệ để biết thêm')

