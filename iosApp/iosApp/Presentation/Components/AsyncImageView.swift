//
//  AsyncImageView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 19.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct AsyncImageView: View {
    
    let url: String
    let size: CGFloat
    
    init(url: String, size: CGFloat) {
        self.url = url
        self.size = size
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { Image in
            Image
                .resizable()
                .scaledToFit()
                .clipShape(.circle)
                
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: size, height: size)
        .padding(.vertical)
    }
}

#Preview {
    AsyncImageView(url: "", size: 120)
}

#Preview {
    ContainerView()
}
