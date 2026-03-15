
## Mục đích

Đây là bản tuỳ biến từ dự án JSymphonic Revival mình code lại thay cho Sonic Stage lỗi thời và dễ crash
Là chút lòng thành gửi ae trong nhóm Hội người nghiện MP3 - CD- sony walkman- Tai Nghe & Máy Nghe Nhạc vì đã trả lời các câu hỏi của em :D
Cảm ơn bác "Bố Yuki" đã giúp em nhớ ra dự án này và làm sau 1 tháng e quên :))) 


Ứng dụng này là trình quản lý nhạc cho Sony Walkman. Chức năng chính:

- Nhập nhạc từ máy tính vào Walkman
- Xuất nhạc từ Walkman ra máy tính
- Xoá nhạc trên Walkman
- Mount và unmount thiết bị trong JSymphonic
- Tạo lại cơ sở dữ liệu nhạc trên thiết bị
- Transcode một số định dạng qua `ffmpeg.exe` khi cần

## Những gì đã được sửa trong bản này

- Đặt ngôn ngữ mặc định là `Tiếng Việt` cho cấu hình mới
- Thêm bộ localization `vi_VN` cho các nhóm text giao diện chính
- Đổi tên hiển thị của app thành `Binh Tagilla JSymphonic Revival v0.5.3`
- Thêm popup chào mừng chỉ hiện 1 lần ở lần chạy đầu
- Popup lần đầu có credit bản sửa bởi Binh Tagilla, link profile và link repo revival hiện tại
- Cải thiện màn hình cấu hình lần đầu, thêm hướng dẫn rõ hơn ở mục chọn thư mục thiết bị
- Thêm cách build `.exe` Windows theo hướng portable, có thể bundle sẵn Java 8 runtime để máy đích không cần cài Java

## Credit

Bản tuỳ biến:

- Binh Tagilla
- Profile: https://binhtagilla.id.vn

Tác giả gốc và nguồn tham khảo:

- JSymphonic gốc: Patrick Balleux, Nicolas Cardoso De Castro, Daniel Zalar
- Repo revival đang dùng làm nền: https://github.com/georgewoodall82/jsymphonic

## Cách chạy app

Nếu chỉ chạy bằng jar:

1. Cần Java 8 hoặc mới hơn
2. Chạy:

```bash
java -jar target/jsymphonic-0.5.3-jar-with-dependencies.jar
```

Nếu dùng gói Windows portable đã bundle sẵn runtime:

1. Mở thư mục build ra
2. Bấm `BinhTagilla-JSymphonic.exe`
3. Không cần cài Java trên máy đích nếu runtime đã được bundle sẵn

## Cấu hình lần đầu

Khi app mở lần đầu, sẽ có màn hình cấu hình thiết bị.

Bạn cần:

1. Bấm nút chọn thư mục
2. Chọn thư mục gốc của Walkman
3. Thư mục này nên chứa `OMGAUDIO` hoặc `ESYS`
4. Chọn đúng đời máy trong danh sách
5. Bấm `Áp dụng`

Nếu đặt sai đường dẫn thiết bị, app vẫn mở được nhưng sẽ không mount đúng nội dung của máy nghe.

## Build source

Lệnh build jar:

```bash
mvn package
```

Kết quả:

- `target/jsymphonic-0.5.3-jar-with-dependencies.jar`

## Build Windows EXE portable

Nếu build trên Linux, nhất là Arch:

```bash
./scripts/build-windows-exe.sh
```

Script Linux sẽ:

1. Build `.exe` wrapper
2. Tự động tải JRE Windows 8 từ Adoptium
3. Nhúng sẵn JRE vào gói portable

Nếu build trên Windows:

Script build:

```bat
scripts\build-windows-exe.bat
```

Script này sẽ:

1. Build fat jar
2. Tạo `.exe` wrapper cho Windows
3. Copy Java 8 runtime vào cùng gói portable
4. Tạo thư mục output ở:

```text
build\windows-portable\BinhTagilla-JSymphonic\
```

Trong thư mục output sẽ có:

- `BinhTagilla-JSymphonic.exe`
- `jsymphonic.jar`
- thư mục `jre`
- tuỳ chọn `ffmpeg.exe` nếu bạn tự cung cấp lúc build

## Yêu cầu trên máy build

Cần có:

1. `mvn` trong `PATH`
2. Biến môi trường `JAVA8_RUNTIME_HOME` trỏ đến JRE/JDK 8

Ví dụ:

```bat
set JAVA8_RUNTIME_HOME=C:\Java\jre8
scripts\build-windows-exe.bat
```

Nếu muốn copy thêm `ffmpeg.exe` vào gói portable ngay lúc build:

```bat
set FFMPEG_EXE=C:\ffmpeg\bin\ffmpeg.exe
scripts\build-windows-exe.bat
```

## Máy đích có cần cài gì không

Nếu gói portable đã có sẵn thư mục `jre`:

- Không cần cài Java
- Có thể bấm mở `BinhTagilla-JSymphonic.exe` trực tiếp
- Bản build Linux đã được chỉnh để tự tải và nhúng sẵn JRE Windows vào gói

Nếu muốn transcode các định dạng không được máy hỗ trợ sẵn:

- Cần `ffmpeg.exe`
- Nếu không có `ffmpeg.exe`, app vẫn mở và vẫn dùng được các chức năng không cần transcode

## Giới hạn tương thích Windows

Phần này cần nói rõ:

- Mục tiêu thực tế nên xem là Windows 7 tới Windows 11
- Windows XP chỉ là mức best-effort
- Không thể cam kết chắc chắn một gói duy nhất sẽ ổn định trên mọi máy từ XP tới 11

Lý do:

- Java
- wrapper `.exe`
- driver USB
- hành vi hệ thống file trên Windows cũ

## File đã sửa trong bản này

- `pom.xml`
- `scripts/build-windows-exe.bat`
- `src/main/java/org/danizmax/jsymphonic/gui/SettingsHandler.java`
- `src/main/java/org/danizmax/jsymphonic/gui/JSymphonicWindow.java`
- `src/main/java/org/danizmax/jsymphonic/gui/JSymphonicFirstConfig.java`
- `src/main/resources/localization/*.properties`

## Ghi chú kiểm tra

Môi trường hiện tại không có `mvn`, nên chưa build verify được artifact thực sự trên máy đang sửa.

Nhưng đã kiểm tra tính nhất quán key localization và đã chuẩn bị đầy đủ script, config và tài liệu để build trên Windows.
