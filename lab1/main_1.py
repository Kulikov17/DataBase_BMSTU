import csv
from random import *
from faker import Faker

records = 1001
people = []
people_health = ['alive' for _ in range(2000)]
ts = []
dtp = []

alph = ['Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Z','X','C','V','B','N','M']

def generateModel():
    string = ''
    string+=choice(alph)
    string+=choice(alph)
    string+=str(randint(0, 10))
    string+=str(randint(0, 10))
    return string

def generateUniqeString():
    array = []
    for i in range(0, 2000):
        while True:
            string = generateNumber(10)
            print(len(string))
            if string not in array:
                array.append(string)
                break
            else:
                continue
    return array


def generateNumber(count):
    return ''.join(str(randint(0,9)) for _ in range(count))


def createPeople():
    with open('people.csv', 'w', newline='', encoding='utf-8') as csvfile:
    #with open('people.csv', 'w', newline='') as csvfile:
        fieldnames = ['person_name', 'sex', 'birthdate', 'passport', 'drive_license']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        #writer.writeheader()
        for i in range(len(people)):
            writer.writerow(people[i])
    print("Writing complete")

def createTS():
    with open('ts.csv', 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['id_person', 'type_ts', 'brand', 'model', 'release_year', 'register_number', 'color']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        #writer.writeheader()
        for i in range(len(ts)):
            writer.writerow(ts[i])
    print("Writing complete")

def createDTP():
    with open('dtp.csv', 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['date_dtp', 'time_dtp', 'region_dtp', 'city_dtp', 'type_dtp']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        #writer.writeheader()
        for i in range(len(dtp)):
            writer.writerow(dtp[i])
    print("Writing complete")


def createAffectedDrivers():
    with open('affectedDrivers.csv', 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['id_dtp', 'id_person', 'id_ts', 'type_driver', 'state_health', 'guilt']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        #writer.writeheader()
        for i in range(len(postDriver)):
            writer.writerow(postDriver[i])
    print("Writing complete")


def createAffectedOthers():
    with open('affectedOthers.csv', 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['id_dtp', 'id_person', 'type_person', 'state_health', 'guilt']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        #writer.writeheader()
        for i in range(len(postOther)):
            writer.writerow(postOther[i])
    print("Writing complete")

people_id = [[i] for i in range(2000)]
def getPeople():
    fake = Faker('ru_RU')
    passport = generateUniqeString()
    drive_license = generateUniqeString()
    sex = ["муж", "жен"]
    for i in range(0, 2000):
        sex_person = choice(sex)
        if sex_person == "муж":
            name_person = fake.name_male()
        else:
            name_person = fake.name_female()
        birthdate_person = fake.date()
        if birthdate_person > "2006-01-01":
            passport_person = "NULL"
        else:
            passport_person = passport[i]
        if birthdate_person > "2002-01-01":
            drive_license_person = "NULL"
        else:
            drive_license_person = drive_license[i]
        people.append(dict([
          #  ('id_person', i),
            ('person_name', name_person),
            ('sex', sex_person),
            ('birthdate', birthdate_person),
            ('passport', passport_person),
            ('drive_license', drive_license_person)
        ]
        ))

ts_cucher = []
ts_bycicle = []
ts_machine = []
ts_motocycle = []

ts_id = [ i for i in range(records)]
def getTS():
    typeTS = ['легковой автомобиль', 'грузовой автомобиль', 'мотоцикл', 'трамвай', 'автобус', 'троллейбус', 'поезд', 'гужевой транспорт', 'велосипед']
    markaLAuto = ['Alpha Romeo', 'Aston Martin', 'Audi', 'Bentley', 'BMW', 'Bugatti',
                 'Cadillac', 'Chevrolet', 'Chery', 'Citroen', 'Corvette', 'Daewoo', 'Ferrari',
                 'Ford', 'Haval', 'Honda', 'Hyundai', 'Infinity', 'Jaguar', 'Jeep', 'Kamaz',
                 'KIA', 'Lada', 'Lifan', 'Lamborghini', 'Land Rover', 'Lexus', 'Mazda', 'Mini',
                 'Mercedes-Benz', 'Mitsubishi', 'Nissan', 'Opel', 'Peugeot', 'Porsche', 'Renault',
                 'Skoda', 'Suzuki', 'Tesla', 'Tayota', 'UAZ', 'Volvo', 'Volkswagen']
    markaGAuto = ['Тонор', 'БелАз', 'MAN', 'KAMAZ', 'MAZ', 'Foton']
    markaTrain = ['Уралтрансмаш', 'Рузхиммаш', 'Новокузнецкий ВСЗ', 'Метровагонмаш', 'Коломенский завод']
    markaBus = ['ГАЗ', 'ЗИЛ', 'ЛАЗ', 'РАФ']
    markaBicycle = ['Eltreco', 'KHE', 'Maxiscoo', 'Polisport', 'Scott', 'Stern', 'Trek']
    markaAnimal = ['Лошади', 'Волы', 'Буйволы', 'Ослы', 'Мулы', 'Собаки', 'Олени', 'Овцы']
    markaMotocycle = ['Hero', 'Irbis', 'Suzuki', 'BMW', 'Harley-Davidson', 'Triumph', 'Kawasaki', 'Honda',
                      'Yamaha', 'Ducati']

    color = ['красный', 'оранжевый', 'желтый', 'зеленый', 'голубый', 'синий', 'фиолетовый',
             'розовый', 'белый', 'черный', 'золотой', 'серебристый', 'коричневый']

    register = generateUniqeString()
    id_person = 0
    for i in range(1, records):
        while True:
            index = randint(1, 1999)
            person = people[index]
            if person.get('passport') == "NULL":
                continue
            else:
                id_person = index
                break

        type_ts = choice(typeTS)
        register_ts = register[i]
        model_ts = generateModel()
        color_ts = choice(color)
        release_year_ts = randint(1980, 2020)

        if type_ts == 'легковой автомобиль':
            marka_ts = choice(markaLAuto)

        if type_ts == 'грузовой автомобиль':
            marka_ts = choice(markaGAuto)

        if type_ts == 'мотоцикл':
            marka_ts = choice(markaMotocycle)

        if type_ts == 'велосипед':
            marka_ts = choice(markaBicycle)
            register_ts = "NULL"

        if type_ts == 'поезд' or type_ts == 'трамвай':
            marka_ts = choice(markaTrain)

        if type_ts == 'автобус' or type_ts == 'троллейбус':
            marka_ts = choice(markaBus)

        if type_ts == 'гужевой транспорт':
            marka_ts = choice(markaAnimal)
            release_year_ts = "NULL"
            model_ts = "NULL"
            color_ts = "NULL"
            register_ts = "NULL"

        ts_dict = dict([
            ('id_person', id_person),
            ('type_ts', type_ts),
            ('brand', marka_ts),
            ('model', model_ts),
            ('release_year', release_year_ts),
            ('register_number', register_ts),
            ('color', color_ts)
        ]
        )

        ts.append(ts_dict)

        if type_ts == 'гужевой транспорт':
            ts_cucher.append([i, ts_dict])
        elif type_ts == 'велосипед':
            ts_bycicle.append([i, ts_dict])
        else:
            ts_machine.append([i, ts_dict])

region = [
'Республика Адыгея',
 'Республика Алтай',
'Алтайский край',
'Амурская область',
'Архангельская область',
'Астраханская область',
'Республика Башкортостан',
'Белгородская область',
'Брянская область',
'Республика Бурятия',
'Владимирская область',
'Волгоградская область',
'Вологодская область',
'Воронежская область',
'Республика Дагестан',
'Еврейская АО',
'Забайкальский край',
'Ивановская область',
'Республика Игушетия',
'Иркутская область',
'Кабардино-Балкария',
'Калининградская область',
'Республика Калмыкия',
'Калужская область',
'Камчатский край',
'Карачаево-Черкесия',
'Республика Карелия',
'Кемеровская область',
'Кировская область',
'Республика Коми',
'Костромская область',
'Краснодарский край',
'Красноярский край',
'Республика Крым',
'Севастополь',
'Курганская область',
'Курская область',
'Ленинградская область',
'Липецкая область',
'Магаданская область',
'Республика Марий Эл',
'Республика Мордовия',
'Москва',
'Московская область',
'Мурманская область',
'Ненецкий АО',
'Нижегородская область',
'Новгородская область',
'Новосибирская область',
'Омская область',
'Оренбургская область',
'Орловская область',
'Пензенская область',
'Пермский край',
'Приморский край',
'Псковская область',
'Ростовская область',
'Рязанская область',
'Самарская область',
'Санкт-Петербург',
'Саратовская область',
'Сахалинская область',
'Свердловская область',
'Республика Северная Осетия - Алания',
'Смоленская область',
'Ставропольский край',
'Тамбовская область',
'Республика Татарстан',
'Тверская область',
'Томская область',
'Тульская область',
'Республика Тыва',
'Тюменская область',
'Удмуртская Республика',
'Ульяновская область',
'Хабаровский край',
'Республика Хакасия',
'Ханты-Мансийский АО',
'Челябинская область',
'Республика Чечня',
'Чувашская Республика',
'Чукотский АО',
'Республика Саха (Якутия)',
'Ямало-Ненецкий АО',
'Ярославская область']

city = [[] for i in range(85)]
def readCity():
    f = open('city.txt')
    for line in f:
        newline = line.replace('),\n', '')
        newline = newline.replace('(', '')
        newline = newline.replace(';', '')
        newline = newline.replace(')', '')
        newline = newline.replace("'", '')
        tmp = newline.split(', ')
        city[int(tmp[1])-1].append(tmp[2])



count_type_dtp = [[] for _ in range(records)]
type_participant_dtp = [[] for _ in range(records)]

id_dtp = [ i for i in range(records)]
def getDTP():
    for i in range(1, records):
        date = ''
        year = randint(2018, 2020)
        date += str(year)
        date += '-'
        month = randint(1, 12)
        if month < 10:
            date += '0'
        date += str(month)
        date += '-'
        tmp = randint(1, 31)
        if month == 2:
            if year == 2020:
                tmp = randint(1, 29)
            else:
                tmp = randint(1, 28)
        elif month == 4 or month == 6 or month == 9 or month == 11:
            tmp = randint(1, 30)
        else:
            tmp = randint(1, 31)
        if tmp < 10:
            date += '0'
        date += str(tmp)

        time = ''
        tmp = randint(0, 23)
        if tmp < 10:
            time += '0'
        time += str(tmp)
        time += ':'
        tmp = randint(0, 59)
        if tmp < 10:
            time += '0'
        time += str(tmp)

        index_r = randint(0, 84)
        region_dtp = region[index_r]

        index_c = randint(0, len(city[index_r]) - 1)
        city_dtp = city[index_r][index_c]

        count_tag_dtp = randint(1, 3)

        passanger = 0
        driver = 1
        bicyclist = 0
        walker = 0
        cucher = 0

        for j in range(count_tag_dtp):
            while True:
                tmp = str(randint(1, 10))
                if tmp not in count_type_dtp[i]:
                    count_type_dtp[i].append(tmp)
                    if tmp == '1':
                        driver += 1
                    if tmp == '8':
                        passanger = 1
                    if tmp == '4':
                        walker = 1
                    if tmp == '5':
                        bicyclist = 1
                    if tmp == '6':
                        cucher = 1
                    break
                else:
                    continue

        count_part_dtp = driver + passanger + walker + bicyclist + cucher

        tmp = count_part_dtp
        if count_part_dtp < 5:
            count_part_dtp = randint(count_part_dtp, 5)

        for _ in range(tmp, count_part_dtp):
            passanger += 1

        type_participant_dtp[i].append(driver)
        type_participant_dtp[i].append(passanger)
        type_participant_dtp[i].append(walker)
        type_participant_dtp[i].append(bicyclist)
        type_participant_dtp[i].append(cucher)

        arr_type_dtp = "{"
        arr_type_dtp += ','.join(count_type_dtp[i])
        arr_type_dtp += "}"
        dtp.append(dict([
            ('date_dtp', date),
            ('time_dtp', time),
            ('region_dtp', region_dtp),
            ('city_dtp', city_dtp),
            ('type_dtp', arr_type_dtp)
            ]))

postDriver = []
postOther = []
use_people = [[]for _ in range(records)]
use_ts = [[]for _ in range(records)]

def getDriver():
    for i in range(1, records):
        for j in range(len(type_participant_dtp[i])):
            if j == 1 or j == 2 or type_participant_dtp[i][j] == 0:
                continue
            for k in range(type_participant_dtp[i][j]):
                while True:
                    person_id = randint(1, 1999)
                    print(person_id)
                    print(people[person_id])
                    print(people[person_id - 1])
                    if people_health[person_id - 1] == 'death' or people[person_id - 1].get('drive_license') == 'NULL':
                        print("ok")
                        continue
                    else:
                        if person_id not in use_people[i]:
                            use_people[i].append(person_id)
                            break
                        else:
                            continue
                while True:
                    if j == 0:
                        ts_dtp = choice(ts_machine)
                        ts_dtp = ts_dtp[0]
                        type_driver = 'водитель'
                    if j == 3:
                        ts_dtp = choice(ts_bycicle)
                        ts_dtp = ts_dtp[0]
                        type_driver = 'велосипедист'
                    if j == 4:
                        ts_dtp = choice(ts_cucher)
                        ts_dtp = ts_dtp[0]
                        type_driver = 'кучер'
                    if ts_dtp not in use_ts[i]:
                        use_ts[i].append(ts_dtp)
                        break
                    else:
                        continue

                health = choice(['ранен', 'погиб', 'цел'])

                if (health == 'погиб'):
                    people_health[person_id - 1] = 'death'

                postDriver.append(dict([
                    ('id_dtp', i),
                    ('id_person', person_id),
                    ('id_ts', ts_dtp),
                    ('type_driver', type_driver),
                    ('state_health', health),
                    ('guilt', choice(['виновен', 'невиновен']))
                ]))


def getOther():
    for i in range(1, records):
        for j in range(len(type_participant_dtp[i])):
            if j == 0 or j == 3 or j == 4 or type_participant_dtp[i][j] == 0:
                continue
            for k in range(type_participant_dtp[i][j]):
                while True:
                    person_id = randint(1, 1999)
                    if people_health[person_id - 1] == 'death':
                        continue
                    else:
                        if person_id not in use_people[i]:
                            if j == 1:
                                type_person = 'пассажир'
                            else:
                                type_person = 'пешеход'
                            use_people[i].append(person_id)
                            break
                        else:
                            continue

                health = choice(['ранен', 'погиб', 'цел'])

                if (health == 'погиб'):
                    people_health[person_id - 1] = 'death'

                postOther.append(dict([
                    ('id_dtp', i),
                    ('id_person', person_id),
                    ('type_person', type_person),
                    ('state_health', health),
                    ('guilt', choice(['виновен', 'невиновен']))
                ]))

typeDTP = [
    {'description': 'Столкновение'},
{'description': 'Наезд на стоящее транспортное средство'},
{'description': 'Наезд на препятствие'},
{'description': 'Наезд на пешехода'},
{'description': 'Наезд на велосипедиста'},
{'description': 'Наезд на гужевой транспорт'},
{'description': 'Падение пассажира'},
{'description': 'Падение перевозимого груза или отброшенного колесом транспортного средства предмета на человека, животное или другое транспортное средство'},
{'description': 'Наезд на внезапно появившееся препятствие'}]

def createTypeDTP():
    with open('typeDTP.csv.csv', 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['description']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        #writer.writeheader()
        for i in range(len(typeDTP)):
            writer.writerow(typeDTP[i])
    print("Writing complete")


if __name__ == '__main__':
    readCity()
    getPeople()
    getTS()
    getDTP()
    getDriver()
    getOther()
    createPeople()
    createTS()
    createDTP()
    createAffectedDrivers()
    createAffectedOthers()
    createTypeDTP()
