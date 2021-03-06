extends Node

const month_list: Array = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]

const weapon: Dictionary = {
"Пусто": 0,
"Винтовка Трехлинейка": 1,
'Эксперементальная Винтовка': 2,
'Винтовка Федорова': 3,
###################################
"Ручной Пулемет Лебеля": 4,
'ПП Манхлера': 5,
'Автомат Ли-Энфильд': 7}

#0 - antipersonnel attack, 1 - anti-tank attack
const weapon_support: Dictionary = {
"Пусто": [0, 0],
"Артеллерия 1910 года": [4, 4],
"Артеллерия 1914 года": [5, 5],
"Артеллерия 1916 года": [6, 6],
"Артеллерия 1918 года": [7, 8],
"Артеллерия Французского образца": [8, 8],
"Гранотомет Алексеева": [1, 1],
"Огнемет 'Клейвф'": [2, 0],
"Переносимый Баскийский пулемет": [3, 0],
"Газовое ружье": [4, 0],
'Противотанковое ружье': [0, 4]}

const support: Dictionary = {
"Пусто": 0,
"Аптечка первой помощи": 1,}

#0 - antipersonnel attack, 1 - anti-tank attack, 2 - HP
const tech: Dictionary = {
"Пусто": [0, 0, 0],
'Машина с пулеметом': [3, 0, 2],
"Первый Броневик Путилова": [3, 0, 3],
"Броневик Путилова": [3, 1, 3],
"Морской Броневик Путилова": [4, 3, 4],
"Броневик Лупковского": [4, 4, 4],
"Морской Броневик Лупковского": [5, 5, 4],
"Легкий танк 'Вездеход'": [3, 1, 3],
"Средний танк 'Галиция'": [4, 3, 4],
"Тяжелый танк Шевченко": [5, 4, 5],
"Газовый Тяжелый танк Шевченко": [6, 4, 5],
'Грузовик I':[0, 0, 1],
'Грузовик II':[0, 0, 3],
'Грузовик III':[0, 0, 4]}



const CompanyName = ['Производсвенно-оборонное предприятие',
'Военно-промышленный комплекс',
'Пушечный двор',
"Кильское Производственное предприятие"]

const tipe_of_units: Dictionary = {
'infantry': null,
'small_tank':["Легкий танк 'Вездеход'"],
'medium_tank':["Средний танк 'Галиция'"],
'heavy_tank':["Тяжелый танк Шевченко", "Газовый Тяжелый танк Шевченко"],
'cavalry': ['Конница'],
'armored_car': ["Первый Броневик Путилова",
"Броневик Путилова",
"Морской Броневик Путилова",
"Броневик Лупковского",
"Морской Броневик Лупковского"],
'motorized_infantry':['Грузовик I', 'Грузовик II', 'Грузовик III']
}

var flags: Dictionary = {
'Республика Адамантия': 1,
'Империя Баскакия': 1,
'Социалистическая Народная Республика Баскакия': 1,
'Народная Республика Горния': 1,
'Легион Насардия': 1,
}



