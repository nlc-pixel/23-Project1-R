install.packages("animation") #adnimation 설치
library(animation) #adnimation 불러오기

setwd("C:/final") #작업폴더 설정

ani.options(interval = 1) #애니메이션 1초

repeat{

#난수 설정

runif <- sample(x=0:100,size=5)
runif #난수 저장 값 출력(테스트)

x <- c(runif)
barplot(x, ylim=c(0,100), col=rainbow(5))

ani.pause() #애니메이션 중지
}
