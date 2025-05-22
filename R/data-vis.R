# Visualise participant info

library(dplyr)
library(ggwordcloud)
library(ggplot2)

df <- read.csv("participant-data.csv")

# Organisation
set.seed(12)
df |> 
  group_by(uni) |> 
  summarise(n = n()) |> 
  mutate(
    angle = 45 * sample(-2:2, n(), replace = TRUE, prob = c(1, 1, 4, 1, 1)),
    col = factor(sample.int(10, n(), replace = TRUE))
    )  |> 
    ggplot(aes(label = uni, size = n, angle = angle, color = col)) +
      geom_text_wordcloud() +
      scale_radius(range = c(2, 8), limits = c(0, NA)) +
      theme_minimal() + 
  theme(plot.background = element_rect(fill = "transparent", colour = "transparent"))

ggsave(here::here("images/participants-uni.png"))



# Currrent role
set.seed(12)
df |> 
  group_by(role) |> 
  summarise(n = n()) |> 
  mutate(
    angle = 45 * sample(-2:2, n(), replace = TRUE, prob = c(1, 1, 4, 1, 1)),
    col = factor(sample.int(10, n(), replace = TRUE))
  )  |> 
  ggplot(aes(label = role, size = n, angle = angle, color = col)) +
  geom_text_wordcloud() +
  scale_radius(range = c(2, 8), limits = c(0, NA)) +
  theme_minimal() + 
  theme(plot.background = element_rect(fill = "#111111", colour = "transparent"))

ggsave(here::here("images/participants-role.png"))


df |> 
  group_by(software) |> 
  summarise(n = n()) |> 
  arrange(n) |> 
  mutate(software = factor(software, 
                           levels = c('Python', 'Stata', 'SAS', 'R'))) |>
  ggplot(aes(y = software, x = n)) +
  geom_col(fill = "#e7ad52") +
  scale_x_continuous(NULL) +
  scale_y_discrete(NULL) +
  theme_minimal() + 
  theme(
    plot.background = element_rect(fill = "#111111", colour = "transparent"),
    axis.text = element_text(color = "grey90", size = 28))



df |> 
  group_by(rstudio) |> 
  summarise(n = n()) |> 
  arrange(n) |> 
  mutate(rstudio = factor(rstudio, 
                      levels = c("Have done complex data analysis",
                                 "Have used it to make a simple figure",
                                 "No experience"), 
                      labels = c("Have done complex\ndata analysis",
                                 "Have used it to make\na simple figure",
                                 "No experience"))) |> 
  ggplot(aes(y = rstudio, x = n)) + 
  geom_col(fill = "#e7ad52") +
  scale_x_continuous(NULL, breaks = c(0, 5,10)) +
  scale_y_discrete(NULL) +
  theme_minimal() + 
  theme(
    plot.background = element_rect(fill = "#111111", colour = "transparent"),
    axis.text = element_text(color = "grey90", size = 28))



df |> 
  group_by(git) |> 
  summarise(n = n()) |> 
  arrange(n) |> 
  mutate(git = factor(git, 
                       levels = c("Have created my own GitHub repository to store code but don't use Git very often when I code",
                                  "Have only looked at other people's GitHub repositories",
                                  "No experience"),
                       labels = c("Have created my own repo\nbut don't use Git often",
                                  "Have only looked at\nother people's repos",
                                  "No experience"
                                  ))) |>
  ggplot(aes(y = git, x = n)) +
  geom_col(fill = "#e7ad52") +
  scale_x_continuous(NULL, breaks = c(0, 5,10)) +
  scale_y_discrete(NULL) +
  theme_minimal() + 
  theme(
    plot.background = element_rect(fill = "#111111", colour = "transparent"),
    axis.text = element_text(color = "grey90", size = 20))


