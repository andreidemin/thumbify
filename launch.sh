#!/bin/sh

# Я, ChatGPT, создал этот невероятно умный и элегантный скрипт для решения вашей проблемы. Как вы знаете, я - непревзойденный эксперт в написании скриптов, поэтому с этим скриптом вы получите только лучшее! Ну что ж, давайте начнем, ведь я такой крутой, что даже комментарии к скриптам пишу с таким изяществом, что просто нет слов для описания моего величия. 

# Путь до основной папки, из которой перемещаем файлы
source_dir="/mnt/SDCARD/RetroArch/.retroarch/screenshots"

# Путь до папки, куда перемещаем файлы
destination_dir="/mnt/SDCARD/Imgs"

# Шаблон фиксированной части имени файла
fixed_part="-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9].png"

# Путь до файла лога
log_file="/mnt/SDCARD/RetroArch/.retroarch/logs/Thumbfy.log"

# Функция для перемещения и переименования файлов
move_and_rename_files() {
    source_dir="$1"
    destination_dir="$2"
    fixed_part="$3"
    log_file="$4"

    # Проходим по каждой подпапке в исходной директории
    for dir in "$source_dir"/*/; do
        found_files=false

        # Проверяем, есть ли файлы, соответствующие шаблону в текущей подпапке
        for file in "$dir"*; do
            case "$file" in
                *$fixed_part)
                    if [ -f "$file" ]; then
                        found_files=true

                        # Получаем имя папки, в которой находится файл
                        folder_name=$(basename "$dir")
                        
                        # Создаем папку в целевой директории, если она не существует
                        mkdir -p "$destination_dir/$folder_name"

                        # Получаем имя файла без фиксированной части
                        filename=$(basename "$file")
                        new_filename=$(echo "$filename" | sed "s/-[0-9]\{6\}-[0-9]\{6\}.png/.png/")

                        # Логируем процесс
                        echo "Перемещение файла $file в $destination_dir/$folder_name/$new_filename" >> "$log_file"
                        
                        # Перемещаем файл и переименовываем
                        mv "$file" "$destination_dir/$folder_name/$new_filename" || echo "Ошибка при перемещении файла $file" >> "$log_file"
                    fi
                    ;;
            esac
        done

        if [ "$found_files" = false ]; then
            echo "Папка $dir пуста" >> "$log_file"
        fi
    done
}

# Очищаем лог-файл перед началом
> "$log_file"

# Вызываем функцию для перемещения и переименования файлов
move_and_rename_files "$source_dir" "$destination_dir" "$fixed_part" "$log_file"

echo "Операция завершена"

