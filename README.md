## Тестовое задание iOS разработчик в Авито

#### Описание
Приложение состоит из двух экранов: 
стартовый экран отображает список товаров. 
<img width="321" alt="AVITOmain" src="https://github.com/ArinLin/AVITO_testTask/assets/100975821/1829f2ff-9b44-4b8c-985a-83360066f6e2">
По нажатию на элемент открывается детальная карточка товара. 
<img width="316" alt="AVITOdetail" src="https://github.com/ArinLin/AVITO_testTask/assets/100975821/df087a7e-4d3c-4818-9650-36fe7e02c843">
Реализована темная/светлая темы. За референс взят внешний вид приложения Авито. 
<img width="315" alt="AVITOmaindark" src="https://github.com/ArinLin/AVITO_testTask/assets/100975821/44059587-b534-4ff7-bd3c-0ab35a150e25">
<img width="316" alt="AVITOdetaildark" src="https://github.com/ArinLin/AVITO_testTask/assets/100975821/dd7a6bb2-7bb7-4e7b-9d21-4900e84d9f54">

#### Для реализации данного приложения использовались:
- Приложение написано на языке Swift
- Архитектура: MVVM
- UI: UIKit (верстка кодом)
- Загрузка данных: Данные загружаются с использованием URLSession
- Отображение списка товаров: используется UICollectionView с отображением в 2 столбца
- Сторонние библиотеки: SDWebImage

#### Каждый экран отображает три состояния:
- Ошибки
- Состояние загрузки
- Отображение контента из JSON файла
