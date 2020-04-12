//
//  StripeCart.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 4/12/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import Foundation

let StripeCart = _StripeCart()

final class _StripeCart {
    
    var cartItems = [Product]()
    private let stripeCreditCardCut = 0.029
    private let flatFeeCents = 30
    var shippingFees = 0
    
    // variables for subtotal, processing fee, total
    // Stripe processee down to the lowest denomination in the locale so in this case pennies / US
    
    var subTotal: Int {
        var amount = 0
        for item in cartItems {
            let pricePennies = Int(item.price * 100)
            amount += pricePennies
        }
        
        return amount
    }
    
    var processingFees: Int {
        if subTotal == 0 {
            return 0
        }
        
        let sub = Double(subTotal)
        let feesAndSub = Int(sub * stripeCreditCardCut) + flatFeeCents
        return feesAndSub
    }
    
    var total: Int {
        return subTotal + processingFees + shippingFees
    }
    
    func addItemToCart(item: Product) {
        cartItems.append(item)
    }
    
    func removeItemFromCart(item: Product) {
        if let index = cartItems.firstIndex(of: item) {
            cartItems.remove(at: index)
        }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
    
}
