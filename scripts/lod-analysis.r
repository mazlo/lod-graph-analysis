
# Load R packages.
library("reshape2")
library("ggplot2")
library("grid")
library("doBy")
library("dplyr")

# Load the results from the graph-analysis tool.  
results <- read.csv("/tmp/lod-graph-analysis-mac.csv", na.strings = "NA")

# Inspect the results.
head(results)
# Total: 280 observations (datasets), 41 variables

resplot <- ggplot(data=results, aes(x= reorder(m, -m))) 

n_plot <- resplot + geom_bar(aes(y=n, fill=domain), position = "dodge", stat="identity") 
n_plot <- n_plot + facet_grid(domain ~ .) + scale_y_log10()
n_plot <- n_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
n_plot

m_plot <- resplot + geom_bar(aes(y=m, fill=domain), position = "dodge", stat="identity") 
m_plot <- m_plot + facet_grid(domain ~ .) + scale_y_log10()
m_plot <- m_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
m_plot

munique_plot <- resplot + geom_bar(aes(y=m_unique/m, fill=domain), position = "dodge", stat="identity") 
munique_plot <- munique_plot + facet_grid(domain ~ .)
munique_plot <- munique_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
munique_plot

filloverall_plot <- resplot + geom_bar(aes(y=fill_overall, fill=domain), position = "dodge", stat="identity") 
filloverall_plot <- filloverall_plot + facet_grid(domain ~ ., scale="free_y")
filloverall_plot <- filloverall_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
filloverall_plot

# Melt degree results to plot multiple metrics in a single plot.
degree_results <- melt(results, id.vars=c("domain", "name", "m"), measure.vars=c("avg_degree", "stddev_in_degree", "stddev_out_degree"), variable.name="var")

degree_plot <- ggplot(data=degree_results, aes(x=reorder(m, -m), y=value, color=var, group=var)) 
degree_plot <- degree_plot + geom_line(size=1, alpha=0.7)
degree_plot <- degree_plot + facet_grid(. ~ domain, scale="free")
degree_plot <- degree_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), panel.grid=element_blank(), legend.position="top")
degree_plot

# Mean degrees accross domains.
mean_degree_table <- aggregate(value~var+domain, data=degree_results, FUN=mean)
mean_degree_table <- dcast(mean_degree_table, domain~var) 
mean_degree_table

hindex_plot <- ggplot(data=results, aes(x=reorder(m, -m), y=h_index_d, color=domain)) 
hindex_plot <- hindex_plot + geom_point(alpha=0.7) + scale_y_log10(breaks=c(1, 10, 100, 1000, 10000)) 
hindex_plot <- hindex_plot + facet_wrap(~ domain, scale="free_x", nrow=2)
hindex_plot <- hindex_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank()) + guides(color=FALSE)
hindex_plot

centralization_plot <- ggplot(data=results, aes(x=reorder(m, -m), y=centralization_degree, color=domain)) 
centralization_plot <- centralization_plot + geom_point(alpha=0.7) #+ scale_y_log10(breaks=c(1, 10, 100, 1000, 10000)) 
centralization_plot <- centralization_plot + facet_wrap(~ domain, nrow=2, scale="free_x")
centralization_plot <- centralization_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank()) + guides(color=FALSE)
centralization_plot

reciprocity_plot <- ggplot(data=results, aes(x=reorder(m, -m), y=reciprocity, color=domain)) 
reciprocity_plot <- reciprocity_plot + geom_point(alpha=0.7)
reciprocity_plot <- reciprocity_plot + facet_wrap(~ domain, scale="free_x", nrow=2)
reciprocity_plot <- reciprocity_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank()) + guides(color=FALSE)
reciprocity_plot

diameter_plot <- ggplot(data=results, aes(x=reorder(m, -m), y=pseudo_diameter, color=domain)) 
diameter_plot <- diameter_plot + geom_point(alpha=0.7)
diameter_plot <- diameter_plot + facet_wrap(~ domain, scale="free", nrow=2)
diameter_plot <- diameter_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank()) + guides(color=FALSE)
diameter_plot

# Datasets with the largest pseudo-diameter values per domain.
max_diameter <- results %>% group_by(domain) %>% summarise(pseudo_diameter = max(pseudo_diameter,na.rm = TRUE))
max_diameter <- merge.data.frame(max_diameter, results)
max_diameter[c("domain", "name", "pseudo_diameter")]

powerlaw_plot <- ggplot(data=results, aes(x=powerlaw_exponent_degree, y=powerlaw_exponent_in_degree, color=domain)) 
powerlaw_plot <- powerlaw_plot + geom_point(aes(size=m), alpha=0.5) + scale_size_continuous(range = c(3,15))
powerlaw_plot <- powerlaw_plot + facet_wrap(~ domain, scale="free", nrow=2)
powerlaw_plot <- powerlaw_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), legend.position="top") + guides(color=FALSE)
powerlaw_plot

# Mean degrees accross domains.
powerlaw_results <- melt(results, id.vars=c("domain", "name", "m"), measure.vars=c("powerlaw_exponent_degree", "powerlaw_exponent_in_degree"), variable.name="var")
powerlaw_table <- aggregate(value~var+domain, data=powerlaw_results, FUN="mean")
powerlaw_table <- dcast(powerlaw_table, domain~var) 
powerlaw_table

variation_plot <- ggplot(data=results, aes(x=coefficient_variation_in_degree, y=coefficient_variation_out_degree, color=domain)) 
variation_plot <- variation_plot + geom_point(aes(size=m), alpha=0.5) + scale_size_continuous(range = c(3,15))
variation_plot <- variation_plot + facet_wrap(~ domain, scale="free", nrow=2)
variation_plot <- variation_plot + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), legend.position="top") + guides(color=FALSE)
variation_plot

library("corrplot")

cor_results <- cor(results[c("n", "m", "m_unique", "max_degree", "max_in_degree", "max_out_degree", "fill", "fill_overall", "reciprocity", "pseudo_diameter", "powerlaw_exponent_degree")], use = "pairwise.complete.obs")
corrplot(cor_results, order = "hclust")




