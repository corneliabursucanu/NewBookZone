//
//  BookModel.swift

//
//  Created by Cornelia Bursucanu on 6/21/17.

//

import Foundation

class BookModel{

    private var _autor: String!
    private var _ISBN: String!
    private var _imagine: String!
    private var _link: String!
    private var _bookKey: String!
    
    
    var autor: String{
        return _autor
    
    }
    
    var ISBN: String{
        return _ISBN
        
    }
    
    var imagine: String{
        return _imagine
        
    }
    
    var link: String{
        return _link
        
    }
    
    var bookKey: String{
        return _bookKey
    
    }
    
    init(autor:String, ISBN:String, imagine: String, link:String) {
        
        self._autor = autor
        self._ISBN = ISBN
        self._imagine = imagine
        self._link = link
        
    }
    
    init(bookKey: String, bookData: Dictionary<String,String>){
    
        self._bookKey = bookKey
        
        if let autor = bookData["Autor"]{
            self._autor = autor
        }
        
        if let ISBN = bookData["ISBN"]{
            self._ISBN = ISBN
        }
        
        if let imagine = bookData["Imagine"]{
            self._imagine = imagine
        }
        
        if let link = bookData["Link"]{
            self._link = link
        }
        
        
    
    
    
    }
    
    
    
    


}
