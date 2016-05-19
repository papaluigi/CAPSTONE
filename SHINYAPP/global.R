library(utils)
library(stringr)

# READ THE FILES
Nfreq3W <- read.csv2(file="Nfreq3W.csv")
Nfreq2W <- read.csv2(file="Nfreq2W.csv")
#freq1W <- read.csv2(file="freq1W.csv")
freq1W <- read.csv2(file="freq1W_th90.csv")

# UPDATE COLNAMES
colnames(Nfreq3W)[which(names(Nfreq3W) == "freq3W.X1")] <- "Freq"
colnames(Nfreq3W)[which(names(Nfreq3W) == "X3")] <- "term"
colnames(Nfreq2W)[which(names(Nfreq2W) == "freq2W.X1")] <- "Freq"
colnames(Nfreq2W)[which(names(Nfreq2W) == "X2")] <- "term"
colnames(freq1W)[which(names(freq1W) == "X1")] <- "Freq"

# CREATE NGRAM COLUMN
freq1W$ngram <- freq1W$term
Nfreq2W$ngram <- paste(Nfreq2W$X1, Nfreq2W$term)
Nfreq3W$ngram <- paste(Nfreq3W$X1, Nfreq3W$X2, Nfreq3W$term)

print("DF loaded !")

nextw <- function(word_seq, res){
  ws_vec <- strsplit(as.character(word_seq), split=" ")
  l <- length(ws_vec[[1]]) # Number of words in the sequence
  if(substr(word_seq,(nchar(word_seq)+1)-1,nchar(word_seq)) == " ") l <- l+1
  print(l)
  
  if (l>=3){
    # Search in trigram table based upon words -3, -2 and -1
    ind <- which(Nfreq3W$X1==word(word_seq, -3))
    df_tri <- Nfreq3W[ind,]
    ind <- which(df_tri$X2==word(word_seq, -2))
    df_tri <- df_tri[ind,]
    ind <- grep(paste("^", word(word_seq, -1), sep=""), df_tri$term)
    res <- df_tri[ind,]
    if (length(res$term)==0) l <- 2
    
  }
  if (l==2){
    # Search in bigram table based upon words -2 and -1
    #ind <- grep(paste("^", word(word_seq, -2), "$", sep=""), Nfreq2W$X1)
    #print(word(word_seq, -2))
    ind <- which(Nfreq2W$X1==word(word_seq, -2))
    df_bi <- Nfreq2W[ind,]
    ind <- grep(paste("^", word(word_seq, -1), sep=""), df_bi$term)
    res <- df_bi[ind,]
    if (length(res$term)==0) l <- 1
    
  }
  if (l==1) {
    # Search in unigram table based upon word being typed
    ind <- grep(paste("^", word(word_seq, -1), sep=""), freq1W$term)
    res <- freq1W[ind,]
  }
  
  
  res <- head(res,20)
  #res <- as.vector(res[,ncol(res)], mode="character")
  print(l)
  print(res)
  #return(res)
  #rownames(res) <- res[,ncol(res)]
  return(res)
}

