SHELL := /bin/bash
arklibgo := ~/ProjectsGo/arkAlias.sh
version = ~/ProjectsGo/arkAlias.sh getlastversion
PROJECTNAME=$(shell basename `pwd`)
.PHONY: check

.SILENT: build run getlasttag win linux wasm www android


linux:
	@echo $$($(version))
	$(info +Компиляция Linux)
	go build -ldflags "-s -w -X 'main.versionProg=$$($(version))'" -o ./bin/main/$(PROJECTNAME) cmd/main/main.go

win:
	$(info +Компиляция windows)
	CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc GOOS=windows GOARCH=amd64 go build -o ./bin/main/$(PROJECTNAME).exe -tags static -ldflags "-s -w -X 'main.versionProg=$$($(version))'" cmd/main/main.go

#wasm:
#	$(info +Компиляция WASM)
#	PROJECTNAME="xxxx" go run gioui.org/cmd/gogio -ldflags "-s -w -X 'main.versionProg=$$($(version))'" -o wasm -target js cmd/main/main.go 

android:
	$(info +Компиляция Android)
	ANDROID_SDK_ROOT=/home/arkadii/Android/Sdk/ go run gioui.org/cmd/gogio -ldflags "-s -w -X 'main.versionProg=$$($(version))'" -o ./bin/main/$(PROJECTNAME).apk -target android -icon appicon.png -arch arm64 -appid Go.arkiv cmd/main/main.go

run: linux 
	$(info +Запуск)
	./bin/main/$(PROJECTNAME)

build: linux win #buildwasm buildandroid
	$(info +Сборка)

#www: build
#	$(info +Старт сервера http://172.16.172.10:8080)
#	goexec 'http.ListenAndServe(":8080", http.FileServer(http.Dir("wasm")))'

