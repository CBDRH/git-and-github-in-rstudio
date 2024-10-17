---
title: "Cleaning data with `dplyr` and friends"
author: "Mark Hanly"
format: 
  revealjs:
    theme: [night, custom.scss]
    highlight-style: monokai
footer: '<a href="/lectures/lectures.qmd">Back</a>'
---


## 

![](../images/horst/tidy-data-friends.jpg)

::: {.figLab}
Illustrations from the [Openscapes](https://www.openscapes.org/) blog [Tidy Data for reproducibility, efficiency, and collaboration](https://www.openscapes.org/blog/2020/10/12/tidy-data/) by Julia Lowndes and Allison Horst"
:::


## 

![](../images/horst/tidy-data-structure.jpg)

::: {.figLab}
Illustrations from the [Openscapes](https://www.openscapes.org/) blog [Tidy Data for reproducibility, efficiency, and collaboration](https://www.openscapes.org/blog/2020/10/12/tidy-data/) by Julia Lowndes and Allison Horst"
:::

## 

:::: {.columns}

::: {.column width=50%}
![](../images/dplyr.png)
:::

::: {.column width=50%}
>dplyr is a grammar of data manipulation, providing a **consistent set of verbs** that help you solve the most common data manipulation challenges

::: {.figLab}
[dplyr.tidyverse.org/](https://dplyr.tidyverse.org/)
:::

:::

::::



## `dplyr` verbs

:::: {.columns}

::: {.column width=50%}
* `filter()`
* `select()`
* `rename()`
* `mutate()`
* `arrange()`
* `slice()`
* `case_when()`
* `pivot_longer()`
:::

::: {.incremental .column width=50%}

* Rename a variable?

* Sort by a given variable?

* Keep rows that match a condition?

* Keep or drop columns?

:::

::::



## Keep rows that match a condition with `filter()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-9|1-2|4-5|7-9|9"}
# Load dplyr library
library(dplyr)

# Load cars dataset
data(cars)

# Filter rows
cars |> 
  filter(speed == 10)
```

::: {.cell-output .cell-output-stdout}

```
  speed dist
1    10   18
2    10   26
3    10   34
```


:::
:::


. . . 

<br>


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-3|3"}
# Filter rows
cars |> 
  filter(speed >= 10 & dist <= 20)
```

::: {.cell-output .cell-output-stdout}

```
  speed dist
1    10   18
2    11   17
3    12   14
4    12   20
5    15   20
```


:::
:::



## Keep rows by position with `slice()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code}
# Slice rows 1 to 3
cars |> 
  slice(1:3)
```

::: {.cell-output .cell-output-stdout}

```
  speed dist
1     4    2
2     4   10
3     7    4
```


:::
:::


. . . 

<br>


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-3|3"}
# Slice last 3 rows
cars |> 
  slice_tail(n=3)
```

::: {.cell-output .cell-output-stdout}

```
  speed dist
1    24   93
2    24  120
3    25   85
```


:::
:::


. . . 

<br>


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-3|3"}
# Slice speediest 3 rows
cars |> 
  slice_max(speed, n=3)
```

::: {.cell-output .cell-output-stdout}

```
  speed dist
1    25   85
2    24   70
3    24   92
4    24   93
5    24  120
```


:::
:::



## Keep or drop columns with `select()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code}
# Filter rows
cars |> 
  select(speed)
```

::: {.cell-output .cell-output-stdout}

```
   speed
1      4
2      4
3      7
4      7
5      8
6      9
7     10
8     10
9     10
10    11
11    11
12    12
13    12
14    12
15    12
16    13
17    13
18    13
19    13
20    14
21    14
22    14
23    14
24    15
25    15
26    15
27    16
28    16
29    17
30    17
31    17
32    18
33    18
34    18
35    18
36    19
37    19
38    19
39    20
40    20
41    20
42    20
43    20
44    22
45    23
46    24
47    24
48    24
49    24
50    25
```


:::
:::



## Select columns with `select()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code}
# Filter rows
cars |> 
  select(starts_with("d"))
```

::: {.cell-output .cell-output-stdout}

```
   dist
1     2
2    10
3     4
4    22
5    16
6    10
7    18
8    26
9    34
10   17
11   28
12   14
13   20
14   24
15   28
16   26
17   34
18   34
19   46
20   26
21   36
22   60
23   80
24   20
25   26
26   54
27   32
28   40
29   32
30   40
31   50
32   42
33   56
34   76
35   84
36   36
37   46
38   68
39   32
40   48
41   52
42   56
43   64
44   66
45   54
46   70
47   92
48   93
49  120
50   85
```


:::
:::



## Rename a variable with `rename()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code}
# rename variable
cars |> 
  rename(distance = dist)
```

::: {.cell-output .cell-output-stdout}

```
   speed distance
1      4        2
2      4       10
3      7        4
4      7       22
5      8       16
6      9       10
7     10       18
8     10       26
9     10       34
10    11       17
11    11       28
12    12       14
13    12       20
14    12       24
15    12       28
16    13       26
17    13       34
18    13       34
19    13       46
20    14       26
21    14       36
22    14       60
23    14       80
24    15       20
25    15       26
26    15       54
27    16       32
28    16       40
29    17       32
30    17       40
31    17       50
32    18       42
33    18       56
34    18       76
35    18       84
36    19       36
37    19       46
38    19       68
39    20       32
40    20       48
41    20       52
42    20       56
43    20       64
44    22       66
45    23       54
46    24       70
47    24       92
48    24       93
49    24      120
50    25       85
```


:::
:::



. . . 

<br>


Note the syntax:


::: {.cell output-location='column-fragment'}

```{.r .cell-code}
data |> 
  rename(`new-name` = `old-name`)
```
:::


## Create new variables with `mutate()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-5|3-5|4"}
# Filter rows
cars |> 
  mutate(
    time = dist / speed
  )
```

::: {.cell-output .cell-output-stdout}

```
   speed dist      time
1      4    2 0.5000000
2      4   10 2.5000000
3      7    4 0.5714286
4      7   22 3.1428571
5      8   16 2.0000000
6      9   10 1.1111111
7     10   18 1.8000000
8     10   26 2.6000000
9     10   34 3.4000000
10    11   17 1.5454545
11    11   28 2.5454545
12    12   14 1.1666667
13    12   20 1.6666667
14    12   24 2.0000000
15    12   28 2.3333333
16    13   26 2.0000000
17    13   34 2.6153846
18    13   34 2.6153846
19    13   46 3.5384615
20    14   26 1.8571429
21    14   36 2.5714286
22    14   60 4.2857143
23    14   80 5.7142857
24    15   20 1.3333333
25    15   26 1.7333333
26    15   54 3.6000000
27    16   32 2.0000000
28    16   40 2.5000000
29    17   32 1.8823529
30    17   40 2.3529412
31    17   50 2.9411765
32    18   42 2.3333333
33    18   56 3.1111111
34    18   76 4.2222222
35    18   84 4.6666667
36    19   36 1.8947368
37    19   46 2.4210526
38    19   68 3.5789474
39    20   32 1.6000000
40    20   48 2.4000000
41    20   52 2.6000000
42    20   56 2.8000000
43    20   64 3.2000000
44    22   66 3.0000000
45    23   54 2.3478261
46    24   70 2.9166667
47    24   92 3.8333333
48    24   93 3.8750000
49    24  120 5.0000000
50    25   85 3.4000000
```


:::
:::



## Create new variables with `mutate()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-7|4-6"}
# Filter rows
cars |> 
  mutate(
    class = ifelse(speed >= 10, 
                   "fast",
                   "slow")
  )
```

::: {.cell-output .cell-output-stdout}

```
   speed dist class
1      4    2  slow
2      4   10  slow
3      7    4  slow
4      7   22  slow
5      8   16  slow
6      9   10  slow
7     10   18  fast
8     10   26  fast
9     10   34  fast
10    11   17  fast
11    11   28  fast
12    12   14  fast
13    12   20  fast
14    12   24  fast
15    12   28  fast
16    13   26  fast
17    13   34  fast
18    13   34  fast
19    13   46  fast
20    14   26  fast
21    14   36  fast
22    14   60  fast
23    14   80  fast
24    15   20  fast
25    15   26  fast
26    15   54  fast
27    16   32  fast
28    16   40  fast
29    17   32  fast
30    17   40  fast
31    17   50  fast
32    18   42  fast
33    18   56  fast
34    18   76  fast
35    18   84  fast
36    19   36  fast
37    19   46  fast
38    19   68  fast
39    20   32  fast
40    20   48  fast
41    20   52  fast
42    20   56  fast
43    20   64  fast
44    22   66  fast
45    23   54  fast
46    24   70  fast
47    24   92  fast
48    24   93  fast
49    24  120  fast
50    25   85  fast
```


:::
:::



## Create new variables with `mutate()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-8|4|5-7"}
# Filter rows
cars |> 
  mutate(
    time = dist / speed,
    class = ifelse(speed >= 10, 
                   "fast",
                   "slow")
  )
```

::: {.cell-output .cell-output-stdout}

```
   speed dist      time class
1      4    2 0.5000000  slow
2      4   10 2.5000000  slow
3      7    4 0.5714286  slow
4      7   22 3.1428571  slow
5      8   16 2.0000000  slow
6      9   10 1.1111111  slow
7     10   18 1.8000000  fast
8     10   26 2.6000000  fast
9     10   34 3.4000000  fast
10    11   17 1.5454545  fast
11    11   28 2.5454545  fast
12    12   14 1.1666667  fast
13    12   20 1.6666667  fast
14    12   24 2.0000000  fast
15    12   28 2.3333333  fast
16    13   26 2.0000000  fast
17    13   34 2.6153846  fast
18    13   34 2.6153846  fast
19    13   46 3.5384615  fast
20    14   26 1.8571429  fast
21    14   36 2.5714286  fast
22    14   60 4.2857143  fast
23    14   80 5.7142857  fast
24    15   20 1.3333333  fast
25    15   26 1.7333333  fast
26    15   54 3.6000000  fast
27    16   32 2.0000000  fast
28    16   40 2.5000000  fast
29    17   32 1.8823529  fast
30    17   40 2.3529412  fast
31    17   50 2.9411765  fast
32    18   42 2.3333333  fast
33    18   56 3.1111111  fast
34    18   76 4.2222222  fast
35    18   84 4.6666667  fast
36    19   36 1.8947368  fast
37    19   46 2.4210526  fast
38    19   68 3.5789474  fast
39    20   32 1.6000000  fast
40    20   48 2.4000000  fast
41    20   52 2.6000000  fast
42    20   56 2.8000000  fast
43    20   64 3.2000000  fast
44    22   66 3.0000000  fast
45    23   54 2.3478261  fast
46    24   70 2.9166667  fast
47    24   92 3.8333333  fast
48    24   93 3.8750000  fast
49    24  120 5.0000000  fast
50    25   85 3.4000000  fast
```


:::
:::



## Create more complex variables with `case_when()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-9|3,9|4,8|5|6|7"}
# Create a new variable
cars |> 
  mutate(
    class = case_when(
      speed <= 4 ~ "slow", 
      speed <= 10 ~ "average", 
      .default = "fast"
    )
  )
```

::: {.cell-output .cell-output-stdout}

```
   speed dist   class
1      4    2    slow
2      4   10    slow
3      7    4 average
4      7   22 average
5      8   16 average
6      9   10 average
7     10   18 average
8     10   26 average
9     10   34 average
10    11   17    fast
11    11   28    fast
12    12   14    fast
13    12   20    fast
14    12   24    fast
15    12   28    fast
16    13   26    fast
17    13   34    fast
18    13   34    fast
19    13   46    fast
20    14   26    fast
21    14   36    fast
22    14   60    fast
23    14   80    fast
24    15   20    fast
25    15   26    fast
26    15   54    fast
27    16   32    fast
28    16   40    fast
29    17   32    fast
30    17   40    fast
31    17   50    fast
32    18   42    fast
33    18   56    fast
34    18   76    fast
35    18   84    fast
36    19   36    fast
37    19   46    fast
38    19   68    fast
39    20   32    fast
40    20   48    fast
41    20   52    fast
42    20   56    fast
43    20   64    fast
44    22   66    fast
45    23   54    fast
46    24   70    fast
47    24   92    fast
48    24   93    fast
49    24  120    fast
50    25   85    fast
```


:::
:::


## Sort variables with `arrange()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code}
# Sort by speed
cars |> 
  arrange(speed)
```

::: {.cell-output .cell-output-stdout}

```
   speed dist
1      4    2
2      4   10
3      7    4
4      7   22
5      8   16
6      9   10
7     10   18
8     10   26
9     10   34
10    11   17
11    11   28
12    12   14
13    12   20
14    12   24
15    12   28
16    13   26
17    13   34
18    13   34
19    13   46
20    14   26
21    14   36
22    14   60
23    14   80
24    15   20
25    15   26
26    15   54
27    16   32
28    16   40
29    17   32
30    17   40
31    17   50
32    18   42
33    18   56
34    18   76
35    18   84
36    19   36
37    19   46
38    19   68
39    20   32
40    20   48
41    20   52
42    20   56
43    20   64
44    22   66
45    23   54
46    24   70
47    24   92
48    24   93
49    24  120
50    25   85
```


:::
:::


## Sort variables with `arrange()`


::: {.cell output-location='column-fragment'}

```{.r .cell-code}
# Sort by speed
cars |> 
  arrange(-speed, dist)
```

::: {.cell-output .cell-output-stdout}

```
   speed dist
1     25   85
2     24   70
3     24   92
4     24   93
5     24  120
6     23   54
7     22   66
8     20   32
9     20   48
10    20   52
11    20   56
12    20   64
13    19   36
14    19   46
15    19   68
16    18   42
17    18   56
18    18   76
19    18   84
20    17   32
21    17   40
22    17   50
23    16   32
24    16   40
25    15   20
26    15   26
27    15   54
28    14   26
29    14   36
30    14   60
31    14   80
32    13   26
33    13   34
34    13   34
35    13   46
36    12   14
37    12   20
38    12   24
39    12   28
40    11   17
41    11   28
42    10   18
43    10   26
44    10   34
45     9   10
46     8   16
47     7    4
48     7   22
49     4    2
50     4   10
```


:::
:::


## The pipe operator `|>` {.smaller}


::: {.cell}

```{.r .cell-code}
# Sort by speed
cars |> arrange(speed)
```
:::

<br>

::: {.incremental}
* `|>` is called the pipe operator
* It takes the object on the left and passes it to the first argument of the function on the right 
:::

. . . 

<br>


::: {.cell}

```{.r .cell-code}
# Equivalent to above code snippet
arrange(cars, speed)
```
:::


<br>

::: {.incremental}
* We can use `|>` to chain multiple `dplyr` verbs 
* keyboard shortcut is Ctrl/Cmd + Shift + M
:::


## The pipe operator `|>`


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-9|3|4|5|1-9"}
# Data prep
cars |> 
  mutate(time = dist / speed) |> 
  arrange(-time) |> 
  slice(1)
```

::: {.cell-output .cell-output-stdout}

```
  speed dist     time
1    14   80 5.714286
```


:::
:::


. . . 

<br>

Often we will save the output of such a chain using the assignment operator `<-`


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-9|2|7"}
# Data prep
longestTime <- cars |>
  mutate(time = dist / speed) |> 
  arrange(-time) |> 
  slice(1)

longestTime
```

::: {.cell-output .cell-output-stdout}

```
  speed dist     time
1    14   80 5.714286
```


:::
:::


## {background-image="../images/Pipe_baking_backAssign.gif" background-size="contain"}


::: {.figLabBR} 
Created by [Arthur Welle](https://github.com/arthurwelle)
:::

## The old pipe operator `%>%` {.smaller}

If you've been using R for a while you may be familiar with the `%>%` pipe operator shipped with the `magrittr` package.

. . . 

<br>

:::: {.columns}

::: {.column}

::: {.cell}

```{.r .cell-code}
# Exactly the same thing!
cars |> 
  mutate(time = dist / speed)  |> 
  arrange(-time)  |>  
  slice(1)
```
:::

:::

::: {.column}

::: {.cell}

```{.r .cell-code}
# Exactly the same thing!
cars %>% 
  mutate(time = dist / speed) %>%
  arrange(-time) %>% 
  slice(1)
```
:::

:::

::::

<br>

::: {.incremental}

* For simple cases, `|>` and `%>%` behave the same
* `|>` is simpler
* `|>` is implemented in base R

:::


## A note on style

:::: {.columns}

::: {.column}


::: {.cell}

```{.r .cell-code}
# Data prep
cars |> 
  mutate(time = dist / speed) |> 
  arrange(-time) |> 
  slice(1)
```
:::


:::

::: {.column .incremental}

* Neat and easy to read!
* Each verb on a new line
* `|>` at end of line
* Indentation
* Use of spacing


:::

::::

. . . 

Avoid this!


::: {.cell}

```{.r .cell-code}
# Data prep
cars|>mutate(time=dist-speed)|>arrange(-time)|>slice(1)
```
:::


##

::: {.callout-tip icon=false}

## {{< fa rocket >}} Mini Exercise

::: {.clock}

{{< fa clock >}} 10 minutes

:::

#### Practice with dplyr!

1. In the RStudio menu navigate to `Tools > Global Options > Code` and tick the box to use the native pipe operator

2. We will use the `penguins` dataset shipped in the `palmerpenguins` library. Determine the longest bill length among the top 5 lightest female penguins from the Gentoo species.


::: {.cell}

```{.r .cell-code}
# Code to get you started
library(palmerpenguins) 

penguins |> 
  filter(species == )
```
:::


:::


## Factors in R {.smaller}

Earlier we used `case_when()` to create a categorical variable with three categories: fast, average, and slow.


::: {.cell output-location='column'}

```{.r .cell-code}
# Create a new variable
cars |> 
  mutate(
    class = case_when(
      speed <= 4 ~ "slow", 
      speed <= 10 ~ "average", 
      .default = "fast"
    )) 
```

::: {.cell-output .cell-output-stdout}

```
   speed dist   class
1      4    2    slow
2      4   10    slow
3      7    4 average
4      7   22 average
5      8   16 average
6      9   10 average
7     10   18 average
8     10   26 average
9     10   34 average
10    11   17    fast
11    11   28    fast
12    12   14    fast
13    12   20    fast
14    12   24    fast
15    12   28    fast
16    13   26    fast
17    13   34    fast
18    13   34    fast
19    13   46    fast
20    14   26    fast
21    14   36    fast
22    14   60    fast
23    14   80    fast
24    15   20    fast
25    15   26    fast
26    15   54    fast
27    16   32    fast
28    16   40    fast
29    17   32    fast
30    17   40    fast
31    17   50    fast
32    18   42    fast
33    18   56    fast
34    18   76    fast
35    18   84    fast
36    19   36    fast
37    19   46    fast
38    19   68    fast
39    20   32    fast
40    20   48    fast
41    20   52    fast
42    20   56    fast
43    20   64    fast
44    22   66    fast
45    23   54    fast
46    24   70    fast
47    24   92    fast
48    24   93    fast
49    24  120    fast
50    25   85    fast
```


:::
:::


## Factors in R {.smaller}

We can `group_by()` this new variable, then use `summarise()` to calculate the average speed for each group.


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-19|9|10-19"}
# Create a new variable
cars |> 
  mutate(
    class = case_when(
      speed <= 4 ~ "slow", 
      speed <= 10 ~ "average", 
      .default = "fast"
    )) |> 
  group_by(class) |>  
  summarise(
    mean = mean(speed)
  ) 
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 3 × 2
  class    mean
  <chr>   <dbl>
1 average  8.71
2 fast    17.1 
3 slow     4   
```


:::
:::


. . . 

Notice the ordering of the output! This is because the new `class` variable is a **character** vector.


## Factors in R {.smaller}

Factors are useful for handling categorical variables.

::: {.incremental}

* Category names
* Ordering categories
* Mapping colors to categories (later!)

:::

. . .

To create a factor you must start by creating a list of the valid **levels**:


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-9|1-4|6-8"}
# Vector of valid levels
classLevels <- c('slow', 
                 'average', 
                 'fast')

# Create factor variable
factor(c('fast', 'slow'), 
       levels = classLevels) 
```

::: {.cell-output .cell-output-stdout}

```
[1] fast slow
Levels: slow average fast
```


:::
:::


## Factors in R {.smaller}

Let's put it all together!


::: {.cell output-location='column-fragment'}

```{.r .cell-code  code-line-numbers="1-19|5-10|5,10"}
# Create a new variable
cars |> 
  mutate(
    class = 
      factor(
        case_when(
          speed <= 4 ~ "slow", 
          speed <= 10 ~ "average", 
          .default = "fast"),
        levels = classLevels)) |> 
  group_by(class) |>  
  summarise(
    mean = mean(speed)
  ) 
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 3 × 2
  class    mean
  <fct>   <dbl>
1 slow     4   
2 average  8.71
3 fast    17.1 
```


:::
:::


. . .

<br>

Now the ordering is by speed class, not alphabetically!


## Moving from wide to long data

Consider the following dataset:


::: {.cell}

:::

