//
//  Models.swift
//  News
//
//  Created by Алексей Трофимов on 04.02.2022.
//


struct News: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String!
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
