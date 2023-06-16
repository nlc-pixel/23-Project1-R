<!--basic
1. 이름 : <h1>
2. 강의날짜 : <h2>
3. 학습내용<필수> : H2이하 사이즈는 자유
4. 작성 코드{선택}
5.최근내용이 위에 오도록
6. 날짜 별 구분이 잘 가도록
-->

<h1>1. 이름 : 손민우</h1>
<h2>2. 강의 날짜 : 2023.05.25</h2>
<h2>(3)방사형 차트</h2>

<li>방사형차트는 레이더 차트나 거미줄 차트라고 함.

<li>다중변수 데이터는 시각화가 어려운데 방사형 차트는 다중변수 데이터를 2차원 평면상에 시각화할 수 있는 몇 안되는 도구 중 하나.

<li>R에서 방사형 차트를 작성하려면 fmsb 패키지 설치

<h2><li>기본차트</h2>

```R
install.packages('fmsb')
library(fmsb) 

# (1) 자료 준비 
score <- c(80,60,95,85,40)
max.score <- rep(100,5)          # 100을 5회 반복
min.score <- rep(0,5)            # 0을 5회 반복
ds <- rbind(max.score,min.score, score)
ds <- data.frame(ds)             # 매트릭스를 데이터프레임으로 변환  
colnames(ds) <- c('국어','영어','수학','물리','음악')
ds

# (2) 방사형 차트 
radarchart(ds)
```
<h2><li>매개변수 지정</h2>
<li>radarchart() 함수는 다양한 매개변수를 지정할 수 있음.

```R
# [코드 12-5]에 이어 실행 
radarchart(ds,                           # 데이터프레임
           pcol='dark green',            # 다각형 선의 색 
           pfcol=rgb(0.2,0.5,0.5,0.5),   # 다각형 내부 색
           plwd=3,                       # 다각형 선의 두께
           cglcol='grey',                # 거미줄의 색
           cglty=1,                      # 거미줄의 타입
           cglwd=0.8,                    # 거미줄의 두께
           axistype=1,                   # 축의 레이블 타입
           seg=4,                        # 축의 눈금 분할                         
           axislabcol='grey',            # 축의 레이블 색
           caxislabels=seq(0,100,25)     # 축의 레이블 값
)
```
<li>radarchart() 함수의 매개변수 설명

- ds : 차트를 작설할 데이터가 저장된 데이터프레임 이름 지정
- pcol='dark green' : 차트 내 다각형의 윤곽선 색을 지정
- pfocl=rgb(0.2,0.5,0.5,0.5) : 차트 내 다각형의 내부 색을 지정
- plwd=3 : 차트 내 다각형의 윤곽선 두께를 지정
- cglcol='grey' : 거미줄의 색을 지정
- cglty=1 : 거미줄의 타입을 지정하며, 1은 실선을 의미
- cglwd=0.8 : 거미줄의 두께를 지정
- axistype=1 : 축의 레이블 타입(0~5) 지정
  - 0 : 눈금에 레이블을 붙이지 않음(기본값)
  - 1 : 차트 상단 중심축에만 레이블 표시
  - 2~5 : 설명 생략
- seg=4 : 축의 눈금 분할을 지정, 이 경우 1~100 사이를 4등분한다(눈금 수는 5)
- axislabcol='grey' : 축의 눈금 레이블 색을 지정
- caxislabels=seq(0,100,25) : 축의 눈금 레이블 값을 지정
  - seq(0,100,25)는 0, 25, 50, 75 100을 의미
  - 매개변수 seq에서 지정한 눈금수와 개수가 맞도록 지정

<h2>4. ggplot </h2>

<li> ggplot 패키지 : ggplot2 설치


<h2><li>막대그래프와 히스토그램</h2>

```R
library(ggplot2)

month <- c(1,2,3,4,5,6)
rain  <- c(55,50,45,50,60,70)
df <- data.frame(month,rain)           # 그래프를 작성할 대상 데이터
df

ggplot(df, aes(x=month,y=rain)) +      # 그래프를 작성할 데이터 지정
  geom_bar(stat='identity',            # 막대그래프의 형태 지정  
           width=0.7,                  # 막대의 폭 지정
           fill='steelblue')           # 막대의 색 지정
```

<li>ggplot() 매개변수

- df : 그래프를 작성할 데이터가 저장되어 있는 데이터프레임을 지정, 매트릭스는 데이터프레임으로 변환하여 입력
- aes(x=month, y=rain) : aes() 함수를 통해 그래프를 그리기 위한 x축, y축 열을 지정
  - x=month : x축을 구성하는 열이 month임을 지정
  - y=rain : y축을 구성하는 열이 rain임을 지정

<li> geom_bar() 매개변수

- stat='identity' : 막대의 높이는 ggplot() 함수에서 y축에 해당하는 열(여기서는 rain)에 의해 결정되도록 지정
- width=0.7 :L 막대의 폭을 지정
- fill='steelblue' : 막대의 내부 색을 지정

```R
# [코드 12-7]에 이어서
ggplot(df, aes(x=month,y=rain)) +      # 그래프를 그릴 데이터 지정
  geom_bar(stat='identity',            # 막대 높이는 y축에 해당하는 열의 값  
           width=0.7,                  # 막대의 폭 지정
           fill='steelblue') +         # 막대의 색 지정
  ggtitle('월별 강수량') +              # 그래프의 제목 지정
  theme(plot.title = element_text(size=25, face='bold', colour='steelblue')) +
  labs(x='월',y='강수량') +            # 그래프의 x, y축 레이블 지정
  coord_flip()                         # 그래프를 가로 방향으로 출력
```

<h2><li>텍스트 마이닝</h2>

```R
install.packages('wordcloud')
library(wordcloud)

word = c("네이버", "카카오", "라인", "쿠팡", "우아한형제들")
frequency = c(4561, 7823, 4537, 7531, 5645)

wordcloud(word, frequency, colors = rainbow(length(word)))
```

<h2>2. 강의 날짜 : 2023.05.18</h2>
학습내용

```R
#11-1
z <- c(1,2,3,NA,5,NA,8)      # 결측값이 포함된 벡터 z
sum(z)                       # 정상 계산이 되지 않음
is.na(z)                     # NA 여부 확인
sum(is.na(z))                # NA의 개수 확인
sum(z, na.rm=TRUE)           # NA를 제외하고 합계를 계산

#11-2
z1 <- c(1,2,3,NA,5,NA,8)      # 결측값이 포함된 벡터 z1
z2 <- c(5,8,1,NA,3,NA,7)      # 결측값이 포함된 벡터 z2
z1[is.na(z1)] <- 0            # NA를 0 로 치환 
z1                            
z3 <- as.vector(na.omit(z2))  # NA를 제거하고 새로운 벡터 생성
z3

#11-3
# NA를 포함하는 test 데이터 생성
x <- iris
x[1,2]<- NA; x[1,3]<- NA
x[2,3]<- NA; x[3,4]<- NA  
head(x)

#11-4
# [코드 11-3]에 이어 실행
# for를 이용한 방법
for (i in 1:ncol(x)) {
  this.na <- is.na(x[,i]) 
  cat(colnames(x)[i], '\t', sum(this.na), '\n')
}

# apply를 이용한 방법
col_na <- function(y) {
  return(sum(is.na(y)))
}

na_count <-apply(x, 2, FUN=col_na)
na_count

#11-5
rowSums(is.na(x))            # 행별 NA 개수  
sum(rowSums(is.na(x))>0)     # NA가 포함된 행의 개수 
sum(is.na(x))                # 데이터셋 전체에서 NA 개수

#11-6
head(x)
x[!complete.cases(x),]              # NA가 포함된 행들을 나타냄
y <- x[complete.cases(x),]          # NA가 포함된 행들을 제거
head(y)                             # 새로운 데이터셋 y의 내용 확인

#11-7
v1 <- c(1,7,6,8,4,2,3)
v1 <- sort(v1)                  # 오름차순
v1
v2 <- sort(v1, decreasing=T)    # 내림차순 
v2

#11-8
name <- c('정대일','강재구','신현석','홍길동')
sort(name)                      # 오름차순
sort(name, decreasing=T)        # 내림차순 

#11-9
name <- c('정대일','강재구','신현석','홍길동')
order(name)                            # 오름차순
order(name, decreasing=T)              # 내림차순

idx <- order(name)
name[idx]                              # 오름차순 정렬

#11-10
head(iris)
order(iris$Sepal.Length)
iris[order(iris$Sepal.Length),]                   # 오름차순으로 정렬
iris[order(iris$Sepal.Length, decreasing=T),]     # 내림차순으로 정렬
iris.new <- iris[order(iris$Sepal.Length),]       # 정렬된 데이터를 저장
head(iris.new)
iris[order(iris$Species, decreasing=T, iris$Petal.Length),]     # 정렬 기준이 2개

#11-11
x <- 1:100
y <- sample(x, size=10, replace=FALSE)    # 비복원 추출
y

#11-12
idx <- sample(1:nrow(iris), size=50, replace=F)
iris.50 <- iris[idx,]      # 50개의 행 추출
dim(iris.50)               # 행과 열의 개수 확인
head(iris.50)

#11-13
sample(1:20, size=5)
sample(1:20, size=5)
sample(1:20, size=5)

set.seed(100)
sample(1:20, size=5)
set.seed(100)
sample(1:20, size=5)
sample(1:20, size=5)

#11-14
combn(1:5,3)              # 1~5에서 3개를 뽑는 조합 

x = c("red","green","blue","black","white")
com <- combn(x,2)         # x의 원소를 2개씩 뽑는 조합 
com

for(i in 1:ncol(com)) {    # 조합을 출력
  cat(com[,i], "\n")
}

#11-15
agg <- aggregate(iris[,-5], by=list(iris$Species), 
                 FUN=mean)
agg

#11-16
agg <- aggregate(iris[,-5], by=list(품종=iris$Species), 
                 FUN=sd)
agg

#11-17
head(mtcars)
agg <- aggregate(mtcars, by=list(cyl=mtcars$cyl,
                                 vs=mtcars$vs),FUN=max)
agg

#12-1
install.packages("treemap")

library(treemap)                     # treemap 패키지 불러오기
data(GNI2014)                        # 데이터 불러오기 
head(GNI2014)                        # 데이터 내용 보기 
treemap(GNI2014,
        index=c('continent','iso3'), # 계층 구조 설정(대륙-국가)
        vSize='population',          # 타일의 크기
        vColor='GNI',                # 타일의 컬러
        type='value',                # 타일 컬러링 방법
        bg.labels='yellow',          # 레이블의 배경색
        title="World's GNI")         # 나무지도 제목  
        
#12-2
library(treemap)                            # treemap 패키지 불러오기
st <- data.frame(state.x77)                 # 매트릭스를 데이터프레임으로 변환
st <- data.frame(st, stname=rownames(st))   # 주의 이름 열 stname을 추가 

treemap(st,
        index=c('stname'),                   # 타일에 주 이름 표기
        vSize='Area',                        # 타일의 크기
        vColor='Income',                     # 타일의 컬러
        type='value',                        # 타일 컬러링 방법
        title='USA states area and income' ) # 나무그림의 제목

#12-3
```

<h2>2. 강의 날짜 : 2023.05.11</h2>
학습내용<p>

10 데이터 탐색하기<br>
(1)이것이 탐색적데이터 분석입니다<br>
<li>데이터 분석의 절차</li><br>
1단계 : 문제 정의 및 계획<br>
2단계 : 데이터 수집<br>
3단계 : 데이터 정제 및 전처리<br>
4단계 : 데이터 탐색<br>
5단계 : 데이터 분석<br>
6단계 : 결과 보고<br>

<li>탐색적 데이터 분석의 이해</li>

|데이터의 종류||자료구조|분석 도구|
|------|---|---|-----|
|단일변수|범주형|팩터,벡터|도수분포표,막대그래프,원그래프|
|단일변수|수치형|벡터|평균,중앙값,분산,4분위수,히스토그램,선그래프,상자그림|
|다중변수|수치형|매트릭스, 데이터프레임|산점도,상관계수,나무지도,방사형차트|

(2)단일변수 데이터를 분석해봅시다.
<li>단일변수 범주형 데이터 분석</li>

```R
install.packages("carData")
library(carData)

# (1) 자료 준비
room.class <- TitanicSurvival$passengerClass  # 선실 정보
room.class                

# (2) 도수분포 계산
tbl <- table(room.class)   
tbl
sum(tbl)                                      # 전체 탑승객수 

# (3) 막대그래프 작성
barplot(tbl, main='선실별 탑승객',       
        xlab='선실 등급',
        ylab='탐승객수',
        col=c('blue', 'green', 'yellow'))                    

#(4) 원그래프 작성
tbl/sum(tbl)                                 # 선실별 탑승객 비율
par(mar=c(1,1,4,1))                     
pie(tbl, main='선실별 탑승객',       
    col=c('blue', 'green', 'yellow'))                    
par(mar=c(5.1,4.1,4.1,2.1))
```

<li>단일변수 수치형 데이터 분석</li>
미국의 주별 고등학교 졸업률 분석하기

```R
# (1) 자료 준비
grad <- state.x77[,'HS Grad']   # 주별 고등학교 졸업율
grad                

# (2) 사분위수
summary(grad)
var(grad)                # 분산
sd(grad)                 # 표준 편차

# (3) 히스토그램
hist(grad, main='주별 졸업율',
     xlab='졸업율',
     ylab='주의 개수',
     col='orange')

# (4) 상자그림
boxplot(grad, main='주별 졸업율',
        col='orange')

# (5) 졸업율이 가장 낮은 주
idx <- which(grad==min(grad))
grad[idx]

# (6) 졸업율이 가장 높은 주
idx <- which(grad==max(grad))
grad[idx]

# (7) 졸업율이 평균 이하인 주
idx <- which(grad<mean(grad))
grad[idx] 
```

영국 폐질환 사망자 분석하기

```R
# (1) 자료 준비
ds <- read.csv('c:/Rworks/fdeaths.csv', row.names='year')
ds

#(2) 선그래프 작성
my.col <- c('black', 'blue','red', 'green','purple','dark gray')
my.lty <- 1:6

plot(1:12,                       # x data
     ds[1,],                     # y data(1974년 자료)
     main='월별 사망자 추이',    # 그래프 제목
     type='b',                   # 그래프 종류
     lty=my.lty[1],              # 선의 종류
     xlab='Month',               # x축 레이블
     ylab='사망자수',            # y축 레이블
     ylim=c(300,1200),           # y축 값의 범위   
     col=my.col[1]               # 선의 색
)

for( i in 2:6) {
  lines(1:12,                      # x data
        ds[i,],                    # y data(1975~1979)
        type='b',                  # 그래프 종류
        lty=my.lty[i],             # 선의 종류
        col=my.col[i]              # 선의 색
  )
}

legend(x='topright',               # 범례의 위치
       lty=my.lty,                 # 선의 종류
       col=my.col,                 # 선의 색
       legend=1974:1979            # 범례의 내용
)

```

(3)다중변수 데이터를 분석해봅시다.
<li>두 변수의 상관관계</li>

```R
# (1) 자료 확인
head(pressure)

# (2) 산점도 작성
plot(pressure$temperature,     # x축 자료
     pressure$pressure,        # y축 자료
     main='온도와 기압',       # 그래프 제목
     xlab='온도(화씨)',        # x축 레이블
     ylab='기압',              # y축 레이블
)
```

상관관계

```R
#(1) 자료의 확인
head(cars)

#(2) 산점도의 작성
plot(cars$speed,                        # x축 자료
     cars$dist,                         # y축 자료
     main='자동차 속도와 제동거리',     # 그래프 제목
     xlab='속도',                       # x축 레이블
     ylab='제동거리',                   # y축 레이블
)

#(3) 상관계수 
cor(cars$speed, cars$dist)
```

<li>다중변수 사이의 상관관계</li>

```R
# (1) 자료 확인
st <- data.frame(state.x77)     # 매트릭스를 데이터프레임으로 변환 
head(st)

# (2) 다중 산점도 작성
plot(st)

# (3) 다중 상관계수
cor(st)
```

11 데이터 전처리 알아보기<br>
(1)결측값에 대해 알아봅시다<br>
<br>
결측값은 데이터의 수집, 저장 과정에서 값을 얻지 못하는 경우가 발생<br>
예를 들면, 통계조사 과정에서 응답자가 어떤 문항에 대해 응답하지 않았다고 하면 그 문항의 데이터 값이 결측값이 됩니다.<br>
결측값은 R에서 NA로 표현<br>
<br>

<li>벡터의 결측값</li>

```R
z <- c(1,2,3,NA,5,NA,8)      # 결측값이 포함된 벡터 z
sum(z)                       # 정상 계산이 되지 않음
is.na(z)                     # NA 여부 확인
sum(is.na(z))                # NA의 개수 확인
sum(z, na.rm=TRUE)           # NA를 제외하고 합계를 계산
```
<br>
NA를 다른값으로 대체하는 방법과 NA를 제거하는 방법

```R
z1 <- c(1,2,3,NA,5,NA,8)      # 결측값이 포함된 벡터 z1
z2 <- c(5,8,1,NA,3,NA,7)      # 결측값이 포함된 벡터 z2
z1[is.na(z1)] <- 0            # NA를 0 로 치환 
z1                            
z3 <- as.vector(na.omit(z2))  # NA를 제거하고 새로운 벡터 생성
z3
```

<li>매트릭스와 데이터프레임의 결측값</li>

```R
# NA를 포함하는 test 데이터 생성
x <- iris
x[1,2]<- NA; x[1,3]<- NA
x[2,3]<- NA; x[3,4]<- NA  
head(x)
```

열별로 결측값이 몇개인지 알아보는 명령어

```R
# [코드 11-3]에 이어 실행
# for를 이용한 방법
for (i in 1:ncol(x)) {
  this.na <- is.na(x[,i]) 
  cat(colnames(x)[i], '\t', sum(this.na), '\n')
}

# apply를 이용한 방법
col_na <- function(y) {
  return(sum(is.na(y)))
}

na_count <-apply(x, 2, FUN=col_na)
na_count
```

행 별로 NA개수를 파악하는 예

```R
rowSums(is.na(x))            # 행별 NA 개수  
sum(rowSums(is.na(x))>0)     # NA가 포함된 행의 개수 
sum(is.na(x))                # 데이터셋 전체에서 NA 개수
```
       
인덱스값

```R
head(x)
x[!complete.cases(x),]              # NA가 포함된 행들을 나타냄
y <- x[complete.cases(x),]          # NA가 포함된 행들을 제거
head(y)                             # 새로운 데이터셋 y의 내용 확인
```
        
     
<h2>2. 강의 날짜 : 2023.04.27</h2>
3. 학습내용
<li>도수분포표 계산하기</li>

```R
fa <- c("winter", "summer", "spring", "sunflower") # 데이터입력
fa #fa의 내용 출력
table(fa) #도수분포 계산
```
<li>막대그래프 작성하기</li>

```R
ds <- table(fa)
ds
barplot(ds, main='favorite season')
```

```R
#barplot에 색상 넣기
barplot(ds, main = "fa season", col='blue')
```

```R
#막대별로 색을 다르게 지정하기
barplot(ds, main = "fa season", col=c('yellow', 'blue', 'red', 'gray'))
```

```R
#x, y축에 설명 붙이기
barplot(ds, main = "fa season", col=c('yellow', 'blue', 'red', 'gray'), xlab="계절", ylab="빈도수")
```

```R
#막대 수평 방향으로 출력
barplot(ds, main = "fa season", col=c('yellow', 'blue', 'red', 'gray'), xlab="계절", ylab="빈도수", horiz=TURE)
```

```R
#x축의 그룹 이름 바꾸기
barplot(ds, main = "fa season", col=c('yellow', 'blue', 'red', 'gray'), xlab="계절", ylab="빈도수", names=c("겨울", "가을", "여름", "봄"))
```

```R
#x축의 그룹 이름을 수직 방향
barplot(ds, main = "fa season", col=c('yellow', 'blue', 'red', 'gray'), xlab="계절", ylab="빈도수", las=2)
```

```R
#중첩 막대그래프
#데이터 입력
age.A <- c(13709, 10974, 7979, 5000, 4250)
age.B <- c(17540, 29701, 36209, 33947, 24487)
age.C <- c(991, 2195, 5366, 12980, 19007)

ds <- rbind(age.A, age.B, age.C)
colnames(ds) <- c('1970','1990','2010','2030','2050')  
ds

#그래프의 작성
barplot(ds, main='인구 추정', col=rainbow(3), beside=1)
```

```R
#범례 추가
barplot(ds, main='인구 추정', col=rainbow(3), beside=1, legend.text=T)
```

```R
#범례를 그래픝 밖에 표시하기
barplot(ds, main='인구 추정', col=rainbow(3), beside=1, legend.text=T,
        args.legend = list(x='topright', bty='n', inset=c(-0.3,-0.1)))
```

```R
#범례 내용 바꾸기
barplot(ds, main='인구 추정', col=rainbow(3), beside=1, 
        legend.text=c('0~14세','15~64세','65세 이상'))
```

```R
#8-15
head(cars)                    
dist <- cars[,2]              # 자동차 제동거리
dist
hist(dist,                    # data
     main='Histogram for 제동거리',   # 제목
     xlab ='제동거리',        # x축 레이블              
     ylab='빈도수',           # y축 레이블                     
     border='blue',           # 막대 테두리색  
     col='green',             # 막대 색
     las=2,                   # x축 글씨 방향(0~3) 
     breaks=5)                # 막대 개수 조절
```


# 코드 8-15에 이어서 실행

```R
result <- hist(dist,                    # data
               main='Histogram for 제동거리',    # 제목
               breaks=5)                # 막대 개수 조절
result
freq <- result$counts                   # 구간별 빈도수 저장
names(freq) <- result$breaks[-1]        # 구간값을 이름으로 지정
freq                                    # 구간별 빈도수 출력
```

```R
#다중 그래프
par(mfrow=c(2,2), mar=c(3,3,4,2))     # 화면 분할(2x2)               

hist(iris$Sepal.Length,               # 그래프 1
     main='Sepal.Length',
     col='orange')             

barplot(table(mtcars$cyl),            # 그래프 2
        main='mtcars',
        col=c('red','green','blue'))              

barplot(table(mtcars$gear),           # 그래프 3
        main='mtcars',
        col=rainbow(3),               # 레인보우 팔레트 사용
        horiz=TRUE)              

pie(table(mtcars$cyl),                # 그래프 4
    main='mtcars',
    col=topo.colors(3),           # topo 팔레트 사용
    radius=2)              
```

```R
par(mfrow=c(1,1), mar=c(5,4,4,2)+.1)  # 화면 분할 취소
```

```R
#원그래프 작성
favorite <- c('WINTER', 'SUMMER', 'SPRING', 'SUMMER', 'SUMMER',
              'FALL', 'FALL', 'SUMMER', 'SPRING', 'SPRING')   # 자료 입력
ds <- table(favorite)                                         # 도수분포 계산
ds                
pie(ds, main='선호 계절',                                     # 원그래프 작성
    radius=1)                                   

#파이 조각의 색 지정하기
# 코드 9-1에 이어서 실행
pie(ds, main='선호 계절',
    col=c('brown','green','red','black'),    # 파이의 색 지정
    radius=1 )                               # 파이의 크기 지정 
```

```R
#3차원 원그래프 작성하기
# 코드 9-1에 이어서 실행
install.packages('plotrix')

library(plotrix)
pie3D(ds, main='선호 계절',
      labels=names(ds),                              # 파이별 레이블 지정
      labelcex=1.0,                                  # 레이블의 폰트 크기
      explode=0.1,                                   # 파이 간 간격
      radius=1.5,                                    # 파이의 크기 
      col=c('brown','green','red','yellow'))         # 파이의 색 지정
```

```R
#하나의 선그래픝 작성하기
month = 1:12                             # 자료 입력
late  = c(5,8,7,9,4,6,12,13,8,6,6,4)     # 자료 입력      
plot(month,                              # x data
     late,                               # y data
     main='지각생 통계',                 # 제목 
     type='l',                           # 그래프의 종류 선택(알파벳) 
     lty=1,                              # 선의 종류(line type) 선택
     lwd=1,                              # 선의 굵기 선택
     xlab='Month',                       # x축 레이블
     ylab='Late cnt'                     # y축 레이블
)
```

<h2>2. 강의 날짜 : 2023.04.13</h2>
3.학습내용 : 
219~2까지
(3)파일 입출력에서 알아야할 내용
<li>실행 결과를 파일로 출력</li>

```R
setwd('C:/Rworks')                              # 작업 폴더 지정
print('Begin work')                             # 화면으로 출력
a <- 10; b <- 20 
sink('result.txt', append=T)                    # 파일로 출력 시작 
cat('a+b=', a+b, '\n')
sink()                                          # 파일로 출력 정지
cat('hello world \n')                           # 화면으로 출력
sink('result.txt', append=T)                    # 파일로 출력 시작 
cat('a*b=', a*b, '\n')
sink()                                          # 파일로 출력 정지
print('End work')                               # 화면으로 출력
```
<li>탭이나 공백으로 부리된 파일 읽기</li>

```R
setwd('C:/Rworks')                                       # 작업 폴더 지정
air <- read.table('airquality.txt', header=T, sep=' ')   # 파일 읽기
head(air)                                                # 내용 확인
```
7 제어문과 사용자 정의 함수 사용하기
(1)이것이 조건문입니다.
<li>if-else문</li>

```R
job.type <- 'A'
if (job.type == 'B') {
  bonus <- 200            # 직군이 B일 때 실행
} else {
  bonus <- 100            # 직군이 B가 아닌 나머지 경우 실행 
}
print(bonus)
```

```R
# else가 생략된 if문
job.type <- 'B'
bonus <- 100           
if (job.type == 'A') {
  bonus <- 200            # 직군이 B일 때 실행
} 
print(bonus)

# -------------------
a <- 10
if (a<5) {
  print(a)
} else {
  print(a*10)
  print(a/10)
}

# -------------------
a <- 10
b <- 20
if (a>5 & b>5) {           # and
  print(a+b)
}
if (a>5 | b>30) {          # or
  print(a*b)
}
```
<li>ifelse문</li>

```R
# if-else를 이용한 처리 ###############
a <- 10
b <- 20

if  (a>b) {
  c <- a
} else {
  c <- b
}
print(c)

# ifelse를 이용한 처리  ###############
a <- 10
b <- 20

c <- ifelse(a>b, a, b)
print(c)
```
<li>if_else의 반복</li>

```R
score <- 85

if (score > 90) {
  grade <- 'A' 
} else if (score > 80) {
  grade <- 'B' 
} else if (score > 70) {
  grade <- 'C' 
} else if (score > 60) {
  grade <- 'D' 
} else {
  grade <- 'F' 
}

print(grade)
```

(2)이것이 반복문입니다.
<li>for문</li>

```R
for(i in 1:5) {
  print('*')
}
```
```R
for(i in 6:10) {
  print(i)
}
```
```R
for(i in 1:9) {
  cat('2 *', i,'=', 2*i,'\n') 
}
```
```R
for(i in 1:20) {
  if(i%%2==0) {          # 짝수인지 확인
    print(i)
  }
}
```
```R
sum <- 0
for(i in 1:100) {
  sum <- sum + i             # sum에 i 값을 누적
}
print(sum)
```
```R
norow <- nrow(iris)                            # iris의 행의 수
mylabel <- c()                                 # 비어있는 벡터 선언
for(i in 1:norow) {
  if (iris$Petal.Length[i] <= 1.6) {          # 꽃잎의 길이에 따라 레이블 결정
    mylabel[i] <- 'L'
  } else if (iris$Petal.Length[i] >= 5.1) {
    mylabel[i] <- 'H'
  } else {
    mylabel[i] <- 'M'
  }
}
print(mylabel)                                   # 레이블 출력
newds <- data.frame(iris$Petal.Length, mylabel)  # 꽃잎 길이와 레이블 결합
head(newds)                                      # 새로운 데이터셋 내용 출력
```
<li>while문</li>

```R
sum <- 0
i <- 1
while(i <=100) {
  sum <- sum + i             # sum 에 i 값을 누적
  i <- i + 1                 # i 값을 1 증가시킴
}
print(sum)
```
<li>apply()계열 함수</li>

```R
apply(iris[,1:4], 1, mean)    # 행 방향으로 함수 적용
apply(iris[,1:4], 2, mean)    # 열 방향으로 함수 적용
```
(3)사용자 정의 함수
<li>사용자 정의함수의 개념</li>

```R
mymax <- function(x,y) {
  num.max <- x
  if (y > x) {
    num.max <- y
  }
  return(num.max) 
} 
```
```R
mymax(10,15)
a <- mymax(20,15)
b <- mymax(31,45)
print(a+b)
```
<li>매개변수에 기본값 설정</li>

```R
mydiv <- function(x,y=2) {
  result <- x/y
  return(result) 
}

mydiv(x=10,y=3)    # 매개변수 이름과 매개변수값을 쌍으로 입력
mydiv(10,3)        # 매개변수값만 입력
mydiv(10)          # x에 대한 값만 입력(y 값이 생략됨)
```
<h2>2. 강의 날짜 : 2023.04.06</h2>
3.학습내용 : 
161~217p까지
<li>행과 얄에 이름 붙이기
score<-matrix(c(90,85,69,78,85,96,49,95,90,80,70,60), nrow=4)
rownames(score)<-c('John', 'Tom', 'Mark', 'Jane')
colnames(score)<-c('English','Math','Science')
score
score['John','Math']
score['Tom',c('Math','Science')]
score['Mark',]
score[,'English']

rownames(score)
colnames(score)
colnames(score)[2]


(2)데이터프레임
<li>데이터프레임 만들기
city<-c("Seoul","Tokyo","Washington")
rank<-c(1,3,2)
city.info<-data.frame(city,rank)
city.info

iris
iris[,c(1:2)]
iris[1:5,c(1,3)]

<li>매트릭스와 데이터프레임
dim(iris)
nrow(iris)
ncol(iris)
colnames(iris)
head(iris)
tail(iris)

str(iris)
iris[,5]
levels(iris[,5])
table(iris[,"Species"])


<li>매트릭스와 데이터프레임에 함수 적용
colSums(iris[,-5])
colMeans(iris[,-5])
rowSums(iris[,-5])
rowMeans(iris[,-5])

#행열 방향 변환
z<-matrix(1:20, nrow=4, ncol=5)
z
t(z)

#조건에 맞는 행과 열의 값 추출
IR.1<-subset(iris,Species=='setosa')
IR.1
IR.2<-subset(iris,Sepal.Length>5.0 &
           Sepal.Width>4.0)

IR.2
IR.2[,c(2,4)]

#매트릭스와 데이터프레임에 산술연산 적용
a<-matrix(1:20,4,5)
b<-matrix(21:40,4,5)
a
b

2*a

a+b
a<-a*3
b<-b-5

<li>매트릭스와 데이터프레임의 자료구조 확인과 변환
#매트릭스와 데이터프레임의 자료구조 확인하기
class(iris)
class(state.x77)
is.matrix(iris)
is.data.frame(iris)
is.matrix(state.x77)
is.data.frame(state.x77)


#매트릭스와 데이터프레임의 자료구조 변환하기
#매트릭스를 데이터프레임으로 변환
is.matrix(state.x77)
st<-data.frame(state.x77)
head(st)
class(st)
#데이터프레임을 매트릭스로 변환
is.data.frame(iris[,1:4])
iris.m<-as.matrix(iris[,1:4])
head(iris.m)
class(iris.m)

<li>데이터프레임에만 적용되는 열 추출방법
iris[,"Species"]
iris[,5]
iris["Species"]
iris[5]
iris$Species


6.데이터 입력하고 출력하기
(1)데이터의 입력과 출력
<li>R에서의 입력과 출력
age<-c(28,17,35,46,23,67,30,50)
age

young<-min(age)
young

old<-max(age)
old

cat('가장 젊은 사람의 나이는 ',young,'이고
    가장 나이든 사람의 나이는',old,'입니다.\n')    


<li>화면에서 데이터 입력받기
install.packages('svDialogs')    
library(svDialogs)
user.input<-dlgInput('input income')$res
user.input
income<-as.numeric(user.input)
income
tax<-income*0.05
cat('세금 :',tax)

result<-sqrt(200)
result

<li>print() 함수와 cat()함수
x<-26
y<-'입니다'
z<-c(10,20,30,40)
print(x)
print(y)
print(z)
print(iris[1:5,])
print(x,y)

cat(x,'\n')
cat(y,'\n')
cat(z,'\n')
cat(x,y,'\n')
cat(iris[1:5],'\n')

(2)파일을 이용해 데이터 읽고 쓰는 방법
<li>작업 폴더
getwd()
setwd('c:/R')
getwd()

<li>.csv 파일 읽기와 쓰기
#읽기
setwd('c:/R')
air<-read.csv('airquality.csv', header=T)
head(air)
class(air)

#쓰기
setwd('c:/r')
my.iris<-subset(iris, Species=='setosa')
write.csv(my.iris, 'my_iris.csv', row.names=F)

<li>엑셀 파일 읽기와 쓰기
install.packages('xlsx')
library(xlsx)
setwd('c:/r')
air <- read.xlsx('airquality.xlsx', header=T, sheetIndex=1)
head(air)


 <h2>2. 강의 날짜 : 2023.03.30</h2>
3.학습내용 : 
<h3>백터 다루기</h3>
(1)자료의 종류
<li>1차원 자료와 2차원 자료</li>
<li>범주형 자료와 수치형 자료<li>
범주형 : 분류의 의미를 갖는 값
수치형 : 값들이 크기를 가지며 산술연산이 가능
(2) 백터 연산
<li> 산술연산 </li>
d <- c(1,4,3,7,8)
2*d
d-5
3*d + 4
실행 결과 : 
2*d
[1]2 8 6 14 16
d-5
[1]-4 -1 -2 2 3
3*d + 4
[1]7 16 13 25 28
<li> 벡터와 벡터의 연산 </li>
벡터 간 대응되는 위치에 있는 값들끼리 연산으로 바뀌어 실행
x <- c(1,2,3,4)
y <- c(5,6,7,8)
x + y
x * y
z <- x + y
z
실행결과 :
x + y
[1]6 8 10 12
x * y
[1]5 12 21 32
z <- x + y
z
[1]6 8 10 12
<li>벡터와 벡터의 연산이 가능하기 위한 조건</li>
1. 두 벡터의 길이가 같아야 합니다.
2. 두 벡터의 포함된 값의 종류가 같아야 합니다.
<li>벡터에 적용 가능한 함수들
sum() : 합계
mean() : 평균
median() : 중앙값
max(), min() : 최댓값, 최솟값
var() : 분산
sd() : 표준편차
sort() : 정렬
range() : 범위
length() : 개수
(3)펙터와 리스트
<li>펙터</li>
문자형 데이터가 저장되는 벡터의 일종, 저장되는 문자값들이 어떠한 종류를 나타내는 값(성별, 혈액형, 선호 정당 등 범주형 자료들)일 때 사용.
펙터는 문자형 벡터를 만든 다음 factor()함수를 이용하여 변환
<li>리스트</li>
벡터가 동일한 자료형의 값들을 1차원 형태로 저장하는 수단이라고하면 리스트는 자료형이 다른 값들을 한곳에 저장하고 다룰 수 있도록 해주는 수단
<h3>매트릭스와 데이터프레임</h3>
(1)매트릭스
<li>매트릭스와 데이터프레임은 2차원 자료를 저장하기 위한 대표적인 자료구조
(2)매트릭스 만들기
z <- matrix(1:20, nrow=4, ncol=5)
z
    [,1][,2][,3][,4][,5]
[1,]  1   5   9  13  17
[2,]  2   6  10  14  18
[3,]  3   7  11  15  19
[4,]  4   8  12  16  20
 <h2>2. 강의 날짜 : 2023.03.23</h2>
3.학습내용 : 
(1)R패키지 설치
<li> 패키지의 개념 : 이러한 함수들을 기능별로 묶어놓은 일종의 꾸러미인데, 어떤 작업을 하느냐에 따라 필요한 패키지도 달라짐
<li> 스스로 공구를 만들어 사용할 수도 있지만 이미 다른 사람들이 잘 만들어 놓은 도구가 있다면 가져다 쓰는 것이 훨씬 효율적임
<li> 로딩 : 패키지를 R에서 사용할 수 있도록 불러오는 작업임
<li> 패키지는 작업 중인 컴퓨터의 특정 폴더에 저장되어 있어야 로딩이 가능함
<li> 원하는 패키지가 없으면 다운로드하여 설치해야 함.
(2)패키지 설치와 사용
<li> 특정 패키지 안에 있는 함수를 이용하려면 다음과 같은 사전 작업이 필요함.
1. 특정 함수를 포함하고 있는 패키지 설치하기(install)
2. 설치한 패키지 불러오기(Load)
<li> 패키지의 설치는 한 번만 필요하지만 패키지 로드는 R 스튜디오가 새로 시작될 때마다 필요.
(3)패키지 설치와 사용
1. 패키지 설치하기
<li> R 스튜디오에서 패키지를 설치하기 전에 인터넷이 연결되어 있는지 먼저 확인
2. 명령문으로 설치하기
<li> R에서 install.packages() 함수를 이용하면 알아서 설치
#ggplot2 패키지 설치
install.packages('ggplot2')
3. R스튜디오 메뉴로 설치하기
4. 패키지 로드하기
#ggplot2 불러오기
library(ggplot2)

(3-1)변수
<li> 변수 만들기 a <- 10
a라는 변수에 10이라는 값을 저장

<li> 변수 내용 확인
total <- 5050
total #방법1
print(total) #방법2
cat('합계 :', totla) #방법3
R스튜디오 윈도우에서도 확인 가능

<li> 변수 산술연산
a<-10, b<-10, C<-a+b

<li> 변수 작명규칙
1. 첫글자는 영문자나 마침표로 시작하는데, 일반적으로 영문자로 시작.
2. 두번째 글자부터는 영문자, 숫자, 마침표, 밑줄을 사용가능
3. 변수명에서 대문자와 소문자는 별개의 문자 취급
4. 변수명 중간에 빈 칸을 넣을 수 없습니다.

(3-2) 벡터
<li> 벡터의 개념
R에서 제공하는 여러 개의 값을 한꺼번에 저자아하는 기능으로 일반적인 프로그래밍 용어로는 1차원 배열이라고도 함.

<li> 벡터 만들기
X <- c #숫자형 벡터
y <- c('a','b','c') #문자형 벡터
z <- c(TRUE, TURE, FALSE, TURE) #논리형 벡터
X
y
z

<li> 벡터의 값에 이름 붙이기
absent <- c (8,2,0,4,1) #absent 벡터에 결근 인원수 저장
absent #출력
naems(absent) #absent 벡터의 값들의 이름을 확인
names(absent) <- c('Mon','Tue','Wed','Thu','Fri') #값들의 이름을 입력
absent #벡터의 ㅐㄴ용 출력
names(absent) #absent 벡터의 값들의 이름을 확인

<li> 벡터에서 원소값 확인하기
인덱스 : R에서 백터에 저장된 각각의 값들을 구별하기 위하여 앞쪽의 값부터 순서를 부여하는 것.
d <- c(1,4,3,7,8)
d #벡터 전체를 출력
d[1]
d[2]
.
.
d[6]

<li> 이름으로 값을 추출하기
sales <- c(640,720,680,540) #1~4월 매출액
names(sales) <- c('M1','M2','M3','M4') #매출액에 월을 이름으로 붙임
sales #1~4월 매출액 출력
sales[1] #1월 매출액 출력
sales['M2'] #2월 매출액 출력
sales[c('M1','M4')] #1월, 4월 매출액 출력

<li> 벡터에 저장된 원소값 변경하기
v1 <-c(1,5,7,8,9)
v1
v1[2] <- 3 #v1의 두번째 값을 3으로 변경
v1[c(1,5)] <-c(10,20) #v1의 1,5번째 값을 각각 10, 20으로 변경
v1 <-c (100,200,300) v1의 내영을 100, 200 , 300으로 변경




4.작성코드
<h2>2. 강의 날짜 : 2023.03.16</h2>
3.학습내용 : 
R언어의 특징
<li> 다양한 패키지 제공
<li> 미적이고 기능적인 통계 그래프 제공
<li> 편리한 프로그래밍 환경
<li> 무료 사용 언어
R을 배우는 이유
-4차 산업혁명
 인공지능과 빅데이터의 핵심 기술
 R은 배우기 쉬우면서도 강력한 데이터 처리 및 분석 능력 제공
 컴퓨팅 사고 능력 습득
R언어, R스튜디오 설치
 R설치
 R Studio 설치
4.작성코드
<h2>2. 강의 날짜 : 2023.03.16</h2>
3.학습내용 : 
R언어의 특징
<li> 다양한 패키지 제공
<li> 미적이고 기능적인 통계 그래프 제공
<li> 편리한 프로그래밍 환경
<li> 무료 사용 언어
R을 배우는 이유
-4차 산업혁명
 인공지능과 빅데이터의 핵심 기술
 R은 배우기 쉬우면서도 강력한 데이터 처리 및 분석 능력 제공
 컴퓨팅 사고 능력 습득
R언어, R스튜디오 설치
 R설치
 R Studio 설치
4.작성코드
