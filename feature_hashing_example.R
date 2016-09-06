library(FeatureHashing)
library(data.table)

vals = letters[1:5]

d = data.table(x = sample(letters, size=10, replace=TRUE))
mat = hashed.model.matrix( ~ x + 0, data=d, hash.size=2)
apply(mat[, -1], 1, which.max)
# Is this a bug?
mat = hashed.model.matrix( ~ x, data=d, hash.size=2)

d[, n_vals := rbinom(10, size=3, p=.3) + 1]
d[, x := sapply(n_vals, function(n) paste(sample(vals, size=n), collapse=","))]
hashed.model.matrix( ~ x + 0, data=d, hash.size=2)
hashed.model.matrix( ~ split(x, delim=",", type="existence") + 0, data=d, hash.size=2)
hashed.model.matrix( ~ split(x, delim=",", type="count") + 0, data=d, hash.size=2)