@ECHO OFF

cd C:\Users\jorge.prado\Downloads\pessoais\Projetos\APIs_JAVA\compras

set JAVA_HOME=c:\java\jdk-21

set PATH=%JAVA_HOME%\bin;%PATH%

mvnw.cmd spring-boot:run