library(fpp3)

## ---- GDP ----------------------------------------------------------------

gdppc <- global_economy %>%
  mutate(GDP_per_capita = GDP / Population) %>%
  select(Year, Country, GDP, Population, GDP_per_capita)
gdppc

gdppc %>%
  filter(Country == "Sweden") %>%
  autoplot(GDP_per_capita) +
  labs(title = "GDP per capita for Sweden", y = "$US")

fit <- gdppc %>%
  model(trend_model = TSLM(GDP ~ trend()))

fc <- fit %>% forecast(h = "3 years")

fc %>%
  filter(Country == "Sweden") %>%
  autoplot(global_economy) +
  labs(title = "GDP per capita for Sweden", y = "$US")

## ---- Bricks ------------------------------------------------------------

brick_fit <- aus_production %>%
  filter(!is.na(Bricks)) %>%
  model(
    Seasonal_naive = SNAIVE(Bricks),
    Naive = NAIVE(Bricks),
    Drift = RW(Bricks ~ drift()),
    Mean = MEAN(Bricks)
  )

brick_fc <- brick_fit %>%
  forecast(h = "5 years")

brick_fc %>%
  autoplot(aus_production, level = NULL) +
  labs(
    title = "Clay brick production for Australia",
    y = "Millions of bricks"
  ) +
  guides(colour = guide_legend(title = "Forecast"))


## ---- Facebook -------------------------------------------------------------------

# Extract training data
fb_stock <- gafa_stock %>%
  filter(Symbol == "FB") %>%
  mutate(trading_day = row_number()) %>%
  update_tsibble(index = trading_day, regular = TRUE)

fb_stock %>% autoplot(Close) +
  labs(
    title = "Facebook closing stock price",
    y = "$US"
  )

# Specify, estimate and forecast
fb_stock %>%
  model(
    Mean = MEAN(Close),
    Naive = NAIVE(Close),
    Drift = RW(Close ~ drift())
  ) %>%
  forecast(h = 42) %>%
  autoplot(fb_stock, level = NULL) +
  labs(
    title = "Facebook closing stock price",
    y = "$US"
  ) +
  guides(colour = guide_legend(title = "Forecast"))

fit <- fb_stock %>% model(NAIVE(Close))

augment(fit) %>%
  filter(trading_day > 1100) %>%
  ggplot(aes(x = trading_day)) +
  geom_line(aes(y = Close, colour = "Data")) +
  geom_line(aes(y = .fitted, colour = "Fitted"))

augment(fit) %>%
  autoplot(.resid) +
  labs(
    y = "$US",
    title = "Residuals from naïve method"
  )

augment(fit) %>%
  ggplot(aes(x = .resid)) +
  geom_histogram(bins = 150) +
  labs(title = "Histogram of residuals")

augment(fit) %>%
  ACF(.resid) %>%
  autoplot() +
  labs(title = "ACF of residuals")

gg_tsresiduals(fit)

augment(fit) %>%
  features(.resid, ljung_box, lag = 10, dof = 0)

fc <- fb_stock %>%
  model(
    Mean = MEAN(Close),
    Naive = NAIVE(Close),
    Drift = RW(Close ~ drift())
  ) %>%
  forecast(h = 42)


## EGG PRICES

eggs <- prices %>%
  filter(!is.na(eggs)) %>%
  select(eggs)
eggs %>%
  autoplot(eggs) +
  labs(
    title = "Annual egg prices",
    y = "$US (adjusted for inflation)"
  )

fit <- eggs %>%
  model(rwdrift = RW(log(eggs) ~ drift()))
fit
fc <- fit %>%
  forecast(h = 50)
fc

fc %>% autoplot(eggs) +
  labs(
    title = "Annual egg prices",
    y = "US$ (adjusted for inflation)"
  )

fc %>%
  autoplot(eggs, level = 80, point_forecast = lst(mean, median)) +
  labs(
    title = "Annual egg prices",
    y = "US$ (adjusted for inflation)"
  )

