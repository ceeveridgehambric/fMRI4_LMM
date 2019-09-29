```{r}
library(data.table) 
fMRI4_contfirst_data <- fread('/Users/channingeveridge/FirstCont.csv', stringsAsFactors = TRUE)
str(fMRI4_contfirst_data)
fMRI4_contfirst_data <- filter(fMRI4_contfirst_data, FCont.RT >= 125)
```  

library(lmerTest)
intxmodelfirstcont <- lmer(FContinuous.RT ~ Generation + RelType + Quartile + RelType*Quartile + Generation*RelType + Generation*RelType*Quartile + Generation*Quartile +
                          (1+Quartile|Subject) +
                          (1+Quartile|Item),
                        data = fMRI4_contfirst_data, control = lmerControl(optimizer = 'Nelder_Mead', optCtrl = list(maxfun = 100000)))
summary(intxmodelfirstcont)

```

SIG: Generation, RelType, Quartile, RelType*Quartile, Generation*RelType, Generation*Quartile

library(emmeans)
emmeans(intxmodelfirstcont, pairwise~Quartile, at = list(Quartile = 1:4))
emmeans(intxmodelfirstcont, pairwise~Generation|Quartile, at = list(Quartile = 1:4))
emmeans(intxmodelfirstcont,pairwise~Generation)
emmeans(intxmodelfcont2, pairwise~Generation|RelType)
emmeans(intxmodelfirstcont, pairwise~Generation*RelType|Quartile, at = list(Quartile = 1:4))