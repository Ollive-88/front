![ollive_logo.png](README%20images%2Follive_metadata%2Follive_logo.png)
![ollive_description.png](README%20images%2Follive_metadata%2Follive_description.png)
---
- [📢 프로젝트 개요](#-프로젝트-개요)
    * [기획배경](#기획배경)
    * [목표](#목표)
- [📜 주요 기능 소개](#-주요-기능-소개)
    * [🍲 의](#-의)
    * [🥼 식](#-식)
    * [🏠 주](#-주)
    * [👨‍💼 마이페이지](#-마이페이지)
- [📚 개발환경](#-개발환경)
- [🌐 아키텍처](#-아키텍처)

---
## 📢 프로젝트 개요

### 기획배경
1인가구의 증가와 더불어 생활 서비스 앱 설치자가 꾸준히 증가하는 현상 관측.
![news_about_one_home.png](README%20images%2Follive_metadata%2Fnews_about_one_home.png)
![news_about_app.png](README%20images%2Follive_metadata%2Fnews_about_app.png)

### 목표
- 분야별 서비스가 분리되어 제공됨.
- 오프라인 서비스가 주를 이루고 있음.
<br>
**&rarr; 생활관련 통합 서비스가 필요하다 생각.**

---

## 📜 주요 기능 소개

### 🍲 의
### - 옷 추천 

**추천 Input Data**
- **사용자 입력 항목**
  - 텍스트
  - 외출 목적
- **사용자 미입력 항목**
  - 날씨

**추천 Output Data**
- **아우터, 상의, 하의, 신발 4개 품목에 대해 각 5개씩 추천**.

### 🥼 식
### 1. 레시피 추천 

**추천 Input Data**
- **사용자 입력 항목**
    - 냉장고 보유 재료 목록
    - 제외 재료 목록
  - **사용자 미입력 항목**
      - 레시피에 대한 사용자의 별점 부여 여부
      - 레시피 평균 별점

**추천 Output Data**
- **추천 레시피 10건**

### 2. 레시피 검색 
**사용자가 입력한 보유재료, 제외 재료 기반 레시피에 카테고리 분류를 적용하여 검색 가능**

### 🏠 주
### - 게시판 
**생활 꿀팁 및 정보 공유용 게시판**
- 댓글
- 좋아요
- 태그(태그 기반 검색 가능)


### 👨‍💼 마이페이지
### 1. 회원 정보 관리 

### 2. 재료 관리 

### 

---

## 📚 개발환경
### Front-End
- Dart 3.3.1
- Flutter 3.19.3
  - GetX 4.6.6 (전역 상태 관리)
  - Dio 5.4.1 (http 요청)
  - flutter_secure_storage 9.0.0 (로컬 스토리지 관리)

### Back-End
- Java 17
- Spring Boot 3.2.3
  - Spring Batch
  - Spring Data JPA
  - Spring Data MongoDB
  - QueryDSL
  - Spring Security
- Python 3.12.0
- FastAPI 0.110.1
  - hypercorn 0.16.0

### AI & Crawling 
- Hugging Face
- Scrapy
- BeautifulSoup

### Database
- MySQL 8.0.36
- MongoDB 7.0.7
- Minio

### Dev/Ops
- AWS EC2
- Jenkins 2.448

---

## 🌐 아키텍처


