//
//  DataSource.swift
//  VKApp
//
//  Created by KKK on 20.04.2021.
//

import UIKit

var frends_all: [frendsModel]  = [
    frendsModel(id: 0, nik: "Леха", firstname: "Алексей", lastname: "Алексеев",image: UIImage(named: "im1")!),
    frendsModel(id: 1, nik: "Мишаня", firstname: "Михаил", lastname: "Михайлов",image: UIImage(named: "im2")!),
    frendsModel(id: 2, nik: "Леонид", firstname: "Леонид", lastname: "Александров",image: UIImage(named: "im3")!),
    frendsModel(id: 3, nik: "Саня", firstname: "Алексендр", lastname: "Ogorod",image: UIImage(named: "im4")!),
    frendsModel(id: 4, nik: "Зак", firstname: "Зак", lastname: "Снайдер", image: UIImage(imageLiteralResourceName: "Зак Снайдер")),
    frendsModel(id: 5, nik: "Рэй", firstname: "Рэй", lastname: "Фишер", image: UIImage(imageLiteralResourceName: "Рэй Фишер")),
    frendsModel(id: 6, nik: "Маринка", firstname: "Марина", lastname: "Конфалоне", image: UIImage(imageLiteralResourceName: "Марина Конфалоне")),
    frendsModel(id: 7, nik: "Эйса", firstname: "Эйса", lastname: "Гонсалес", image: UIImage(imageLiteralResourceName: "Эйса Гонсалес")),
    frendsModel(id: 8, nik: "Бланка", firstname: "Бланка", lastname: "уарес", image: UIImage(imageLiteralResourceName: "Бланка Суарес")),
    frendsModel(id: 9, nik: "Белла", firstname: "Белла", lastname: "Хиткот", image: UIImage(imageLiteralResourceName: "Белла Хиткот")),
    frendsModel(id: 10, nik: "Артем", firstname: "Артем", lastname: "Курганский", image: UIImage(imageLiteralResourceName: "Артем Курганский")),
    frendsModel(id: 11, nik: "Денис", firstname: "Денис", lastname: "Пирожков", image: UIImage(imageLiteralResourceName: "Денис Пирожков")),
    frendsModel(id: 12, nik: "Ксения", firstname: "Ксения", lastname: "Середа", image: UIImage(imageLiteralResourceName: "Ксения Середа")),
    frendsModel(id: 13, nik: "Маратик", firstname: "Марат", lastname: "Бушаров", image: UIImage(imageLiteralResourceName: "Марат Бушаров")),
    frendsModel(id: 14, nik: "Чупин", firstname: "Евгений", lastname: "Чупин", image: UIImage(imageLiteralResourceName: "Евгений Чупин")),
    frendsModel(id: 15, nik: "Милана", firstname: "Милана", lastname: "Карагулова", image: UIImage(imageLiteralResourceName: "Милана Карагулова")),
    frendsModel(id: 16, nik: "Софья", firstname: "Софья", lastname: "Баранцева", image: UIImage(imageLiteralResourceName: "Софья Баранцева")),
    frendsModel(id: 17, nik: "Роман", firstname: "Роман", lastname: "Евдокимов", image: UIImage(imageLiteralResourceName: "Роман Евдокимов")),
    frendsModel(id: 18, nik: "Антоша", firstname: "Антон", lastname: "Пиджаков", image: UIImage(imageLiteralResourceName: "Антон Пиджаков")),
    frendsModel(id: 19, nik: "Алина", firstname: "Алина", lastname: "Пилипченко", image: UIImage(imageLiteralResourceName: "Алина Пилипченко")),
    frendsModel(id: 20, nik: "Клара", firstname: "Клара", lastname: "Лаго", image: UIImage(imageLiteralResourceName: "Клара Лаго")),

]


var allGroups: [groupModel] = [
    groupModel(name: "Машины", image: UIImage(named: "car")!),
    groupModel(name: "Отпуск", image: UIImage(named: "otpusk")!),
    groupModel(name: "Работа", image: UIImage(named: "work")!),
    groupModel(name: "UFO", image: UIImage(named: "ufo")!),
]


let news: [newsModel] = [
    newsModel(frend: frends_all[0], headPost: "В Microsoft Store акция", datePost: "10.04.2021", textPost: "В Microsoft Store стартовала новая скидочная акция для экосистемы компании — консолей Xbox и персональных компьютеров под управлением Windows. Как обычно, мы собрали список самых притягательных предложений.", imagePost: UIImage(named: "post1")!),
    newsModel(frend: frends_all[4], headPost: "Фиолетовый iPhone", datePost: "20.04.2021", textPost: "Сегодня, 20 апреля, Apple представила совершенно новую потрясающую фиолетовую отделку для iPhone 12 и iPhone 12 mini. Новый цвет отлично дополняет прекрасный дизайн iPhone 12 с плоскими гранями, который оснащён передовой двухкамерной системой, дисплеем Super Retina XDR с передней крышкой Ceramic Shield и производительным чипсетом A14 Bionic.", imagePost: nil),
    newsModel(frend: frends_all[9], headPost: "Марсоход 21 века", datePost: "04.05.2021", textPost: "Чуть ли не с самого своего появления люди стремятся покорить космос. Сначала все, что мы могли делать — мирно выполнять роль наблюдателей, считая звёзды на небосводе. Потом в космос был впервые отправлен человек. Юрий Алексеевич Гагарин. Немного погодя, в 1969 году Нил Армстронг и Эдвин Олдрин ступили на поверхность Луны. Но на этом достижения не заканчиваются. Цивилизация стремится к большему! В этом материале мы объясним, зачем люди собирают камни на Марсе, что они могут рассказать о нас и красной планете, и почему исследовать космос важно.", imagePost: UIImage(named: "post3")!),

]

/*
let frendCollectionImag: [frendCollectionImages] = [
    frendCollectionImages(images: [UIImage(named: "im1")!, UIImage(named: "frend1")!, UIImage(named: "frend2")!]),
    frendCollectionImages(images: [UIImage(named: "im2")!, UIImage(named: "frend2")!, UIImage(named: "frend3")!, UIImage(named: "frend4")!]),
    frendCollectionImages(images: [UIImage(named: "im3")!, UIImage(named: "frend3")!, UIImage(named: "frend4")!]),
    frendCollectionImages(images: [UIImage(named: "im4")!, UIImage(named: "frend4")!, UIImage(named: "frend5")!, UIImage(named: "frend6")!]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Зак Снайдер"),UIImage(imageLiteralResourceName: "Зак Снайдер-1")]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Рэй Фишер"),UIImage(imageLiteralResourceName: "Рэй Фишер-1")]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Марина Конфалоне"),UIImage(imageLiteralResourceName: "Марина Конфалоне-1")]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Эйса Гонсалес"), UIImage(imageLiteralResourceName: "Эйса Гонсалес-1"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Бланка Суарес"), UIImage(imageLiteralResourceName: "Бланка Суарес-1"), UIImage(imageLiteralResourceName: "Бланка Суарес-2"), UIImage(imageLiteralResourceName: "Бланка Суарес-3"), UIImage(imageLiteralResourceName: "Бланка Суарес-4"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Белла Хиткот"), UIImage(imageLiteralResourceName: "Белла Хиткот-1"), UIImage(imageLiteralResourceName: "Белла Хиткот-2"), UIImage(imageLiteralResourceName: "Белла Хиткот-3"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Артем Курганский"),UIImage(imageLiteralResourceName: "Артем Курганский-1"), ]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Денис Пирожков"), UIImage(imageLiteralResourceName: "Денис Пирожков-1"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Ксения Середа"), UIImage(imageLiteralResourceName: "Ксения Середа-1"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Марат Бушаров"), UIImage(imageLiteralResourceName: "Марат Бушаров-1"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Евгений Чупин"), UIImage(imageLiteralResourceName: "Евгений Чупин-1"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Милана Карагулова"), UIImage(imageLiteralResourceName: "Милана Карагулова-1"), ]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Софья Баранцева"), UIImage(imageLiteralResourceName: "Софья Баранцева-1"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Роман Евдокимов"), UIImage(imageLiteralResourceName: "Роман Евдокимов-1"), ]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Антон Пиджаков"), UIImage(imageLiteralResourceName: "Антон Пиджаков-1"),]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Алина Пилипченко"),UIImage(imageLiteralResourceName: "Алина Пилипченко-1")]),
    frendCollectionImages(images: [UIImage(imageLiteralResourceName: "Клара Лаго"), UIImage(imageLiteralResourceName: "Клара Лаго-1"),]),

]

 */

