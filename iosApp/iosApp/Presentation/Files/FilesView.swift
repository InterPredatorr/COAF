//
//  FilesView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct FilesView: View {
    var body: some View {
        NavigationView(content: {
            Text("Files")
                .toolbar {
                    DS.headerImage
                    ToolbarItem {
                        Button {
                            
                        } label: {
                            Image(systemName: "bell.fill")
                        }
                    }
                    ToolbarItem {
                        Button {
                            
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                }
                .foregroundStyle(Color.accentColor)
                .background(Color.backgroundPrimary)

        })
        
    }
}

#Preview {
    FilesView()
}

#Preview {
    ContainerView()
}
