
## Mục đích
- Đây là bản tuỳ biến từ dự án JSymphonic Revival mình code lại thay cho Sonic Stage lỗi thời và dễ crash
- Là chút lòng thành gửi ae trong nhóm Hội người nghiện MP3 - CD- sony walkman- Tai Nghe & Máy Nghe Nhạc vì đã trả lời các câu hỏi của em :D
- Cảm ơn bác "Bố Yuki" đã giúp em nhớ ra dự án này và làm sau 1 tháng e quên :))) 


Ứng dụng này là trình quản lý nhạc cho Sony Walkman. Chức năng chính:

- Nhập nhạc từ máy tính vào Walkman
- Xuất nhạc từ Walkman ra máy tính
- Xoá nhạc trên Walkman
- Mount và unmount thiết bị trong JSymphonic
- Tạo lại cơ sở dữ liệu nhạc trên thiết bị
- Transcode một số định dạng qua `ffmpeg.exe` khi cần
- Hỗ trợ từ win 7 tới 11 và có cả linux để thay thế sonic stage 


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

Nếu dùng bản Windows portable:

1. Giữ nguyên cả thư mục portable
2. Bấm `BinhTagilla-JSymphonic.exe`
3. Không cần cài Java nếu thư mục `jre` nằm cạnh file exe

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

Portable vẫn được dùng làm đầu vào cho bộ cài Windows.

## Build Windows installer

Nếu build trên Windows:

```bat
scripts\build-windows-installer.bat
```

Kết quả:

- `build\windows-installer\BinhTagilla-JSymphonic-Setup.exe`

Bộ cài này có:

- giao diện cài đặt chuẩn
- chọn thư mục cài đặt
- tiếng Việt
- tùy chọn tạo biểu tượng ngoài màn hình chính
- mở app ngay sau khi cài xong

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
