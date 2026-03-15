# Binh Tagilla JSymphonic Revival

## Muc dich

Day la ban tuy bien tu du an JSymphonic Revival de dung cho nhu cau dong goi va su dung tren Windows voi giao dien mac dinh tieng Viet.

Ung dung nay la trinh quan ly nhac cho Sony Walkman. Chuc nang chinh:

- Nhap nhac tu may tinh vao Walkman
- Xuat nhac tu Walkman ra may tinh
- Xoa nhac tren Walkman
- Mount va unmount thiet bi trong JSymphonic
- Tao lai co so du lieu nhac tren thiet bi
- Transcode mot so dinh dang qua `ffmpeg.exe` khi can

## Nhung gi da duoc sua trong ban nay

- Dat ngon ngu mac dinh la `Tieng Viet` cho cau hinh moi
- Them bo localization `vi_VN` cho cac nhom text giao dien chinh
- Doi ten hien thi cua app thanh `Binh Tagilla JSymphonic Revival v0.5.3`
- Them popup chao mung chi hien 1 lan o lan chay dau
- Popup lan dau co credit ban sua boi Binh Tagilla, link profile va link repo revival hien tai
- Cai thien man hinh cau hinh lan dau, them huong dan ro hon o muc chon thu muc thiet bi
- Them cach build `.exe` Windows theo huong portable, co the bundle san Java 8 runtime de may dich khong can cai Java

## Credit

Ban tuy bien:

- Binh Tagilla
- Profile: https://binhtagilla.id.vn

Tac gia goc va nguon tham khao:

- JSymphonic goc: Patrick Balleux, Nicolas Cardoso De Castro, Daniel Zalar
- Repo revival dang dung lam nen: https://github.com/georgewoodall82/jsymphonic

## Cach chay app

Neu chi chay bang jar:

1. Can Java 8 hoac moi hon
2. Chay:

```bash
java -jar target/jsymphonic-0.5.3-jar-with-dependencies.jar
```

Neu dung goi Windows portable da bundle san runtime:

1. Mo thu muc build ra
2. Bam `BinhTagilla-JSymphonic.exe`
3. Khong can cai Java tren may dich neu runtime da duoc bundle san

## Cau hinh lan dau

Khi app mo lan dau, se co man hinh cau hinh thiet bi.

Ban can:

1. Bam nut chon thu muc
2. Chon thu muc goc cua Walkman
3. Thu muc nay nen chua `OMGAUDIO` hoac `ESYS`
4. Chon dung doi may trong danh sach
5. Bam `Ap dung`

Neu dat sai duong dan thiet bi, app van mo duoc nhung se khong mount dung noi dung cua may nghe.

## Build source

Lenh build jar:

```bash
mvn package
```

Ket qua:

- `target/jsymphonic-0.5.3-jar-with-dependencies.jar`

## Build Windows EXE portable

Neu build tren Linux, nhat la Arch:

```bash
./scripts/build-windows-exe.sh
```

Script Linux se:

1. Build `.exe` wrapper
2. Tu dong tai JRE Windows 8 tu Adoptium
3. Nhung san JRE vao goi portable

Neu build tren Windows:

Script build:

```bat
scripts\build-windows-exe.bat
```

Script nay se:

1. Build fat jar
2. Tao `.exe` wrapper cho Windows
3. Copy Java 8 runtime vao cung goi portable
4. Tao thu muc output o:

```text
build\windows-portable\BinhTagilla-JSymphonic\
```

Trong thu muc output se co:

- `BinhTagilla-JSymphonic.exe`
- `jsymphonic.jar`
- thu muc `jre`
- tuy chon `ffmpeg.exe` neu ban tu cung cap luc build

## Yeu cau tren may build

Can co:

1. `mvn` trong `PATH`
2. Bien moi truong `JAVA8_RUNTIME_HOME` tro den JRE/JDK 8

Vi du:

```bat
set JAVA8_RUNTIME_HOME=C:\Java\jre8
scripts\build-windows-exe.bat
```

Neu muon copy them `ffmpeg.exe` vao goi portable ngay luc build:

```bat
set FFMPEG_EXE=C:\ffmpeg\bin\ffmpeg.exe
scripts\build-windows-exe.bat
```

## May dich co can cai gi khong

Neu goi portable da co san thu muc `jre`:

- Khong can cai Java
- Co the bam mo `BinhTagilla-JSymphonic.exe` truc tiep
- Ban build Linux da duoc chinh de tu tai va nhung san JRE Windows vao goi

Neu muon transcode cac dinh dang khong duoc may ho tro san:

- Can `ffmpeg.exe`
- Neu khong co `ffmpeg.exe`, app van mo va van dung duoc cac chuc nang khong can transcode

## Gioi han tuong thich Windows

Phan nay can noi ro:

- Muc tieu thuc te nen xem la Windows 7 toi Windows 11
- Windows XP chi la muc best-effort
- Khong the cam ket chac chan mot goi duy nhat se on dinh tren moi may XP toi 11

Ly do:

- Java
- wrapper `.exe`
- driver USB
- hanh vi he thong file tren Windows cu

## File da sua trong ban nay

- `pom.xml`
- `scripts/build-windows-exe.bat`
- `src/main/java/org/danizmax/jsymphonic/gui/SettingsHandler.java`
- `src/main/java/org/danizmax/jsymphonic/gui/JSymphonicWindow.java`
- `src/main/java/org/danizmax/jsymphonic/gui/JSymphonicFirstConfig.java`
- `src/main/resources/localization/*.properties`

## Ghi chu kiem tra

Moi truong hien tai khong co `mvn`, nen chua build verify duoc artifact that su trong may dang sua.

Nhung da kiem tra tinh nhat quan key localization va da chuan bi du day script, config va tai lieu de build tren Windows.
