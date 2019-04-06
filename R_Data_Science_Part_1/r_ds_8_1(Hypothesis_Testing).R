# Problem 1: 
 # H0 : mu0 >=10,000 hrs
 # H1 : mu < 10,000 hrs

xbar = 9900 #sample mean
mu0 = 10000 #hypothesized value
sigma = 120   # Pop SD
n = 30

#Method 1: (z in Rejection/Acceptance region)

# Step 1: Find Critical value of z at 0.05 sig level
#lower tailed - z test for this ex

alpha = 0.05
z.alpha = qnorm(1-alpha)  #qnorm getst the z critcal value from given confidence level alpha
-z.alpha  # critical value of z at lower tail

# Step 2: find the z value from data given

z = (xbar - mu0)/(sigma / sqrt(n))
z # test statistic

# since z value < critical (ie in Rejection Region), we reject H0 (-4.56<-1.64)


#Method 2: (P value <= / > alpha )

# finding P value

pval = pnorm(z)
pval

#pval < alpha , therefore reject






####




# Problem 2: 
# H0 : mu0 <= 2
# H1 : mu > 2

# upper tailed - z test

xbar = 2.1 #sample mean
mu0 = 2 #hypothesized value
sigma = 0.25  # Pop SD
n = 35

#Method 1: using z value and z critical


# Step 1: find z value from data given

z = (xbar - mu0)/(sigma / sqrt(n))
z  # test statistic


#Step 2: Find Critical value of z at 0.05 sig level

alpha = 0.05
z.alpha = qnorm(1-alpha)
z.alpha

# since z value > critical (ie. in Rejection region), we reject H0


#Method 2: using P value and alpha value

# finding P value

pval = pnorm(z, lower.tail = F)
pval   # 0.0089  

#pval < alpha , therefore reject




######




# Problem 3

# H0 : mu0 = 15.4
# H1 : mu !=15

xbar = 14.6 #sample mean
mu0 = 15.4 #hypothesized value
sigma = 2.5   # Pop SD
n = 35

# z test, two tailed

#Method 1: z value and critical values

# Step 1: find z value from given data

z = (xbar - mu0)/(sigma / sqrt(n))
z # test statistic
 

alpha = 0.05
z.alpha = qnorm(1-alpha/2)  # alpha/2 since it is two tailed
z.alpha  #upper critical value
-z.alpha  #lower critical value

#  lower critical < z value < value upper critcal value (-1.96 < -1.89 < 1.96), so accept H0

#Method 2: Pval and alpha

#find pval
pval = 2 * pnorm(z)  # mult by 2 since 2 tailed
pval

#pval > alpha so accept




#####



# Problem 4:

# H0 : mu0 >=10,000 hrs
# H1 : mu < 10,000 hrs

xbar = 9900 #sample mean
mu0 = 10000 #hypothesized value
s = 125   # Sample SD
n = 30

# t test, lower tailed

#Method 1: using t value and critical value 

#Step 1: find t value from data given
t = (xbar - mu0)/(s / sqrt(n))
t

#Step 2: find critical value
alpha = 0.05
t.alpha = qt(1 - alpha, df = n-1)  #used to find the critical value using 'df' and 'n-1'
-t.alpha  #lower critical value

# t < t.alpha (-4.38 < -1.69) , therefore reject H0


# Method 2: using Pval and alpha

# Step 1: find pval

pval = pt(t, df = n-1)
pval

#here, pval < alpha, so reject