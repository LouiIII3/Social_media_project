//
//  PostingView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/19/23.
//
import SwiftUI
import PhotosUI
import CoreTransferable


struct SelectingImage: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var selected: PhotosPickerItem?
    @State private var firstPhoto: UIImage?
    @State private var picture: UIImage = UIImage(named: "nopicture")!
    @State private var modal = true
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @GestureState private var magnifyBy = 1.0
    
    @Binding var path: [String]
    //MARK: FUNC
    
    func loadFirstPhoto() {
        // 앨범에서 이미지 가져오기
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if let firstAsset = result.firstObject {
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 1000, height: 1000)
            
            imageManager.requestImage(for: firstAsset,
                                      targetSize: targetSize,
                                      contentMode: .aspectFill,
                                      options: nil) { (image, _) in
                if let image = image {
                    // 이미지를 가져왔을 때
                    picture = image
                } else {
                    // 이미지를 가져오는 데 실패했을 때
                    print("Failed to load image")
                }
            }
        } else {
            // 앨범에 이미지가 없을 때
            print("No images found in the album")
        }
    }
    
    func resetScale() {
        print("초기화")
        scale = 1.0
        offset = .zero
    }
    
    var magnification: some Gesture {
        MagnifyGesture(minimumScaleDelta: 0)
            .onChanged({ value in
                print("확대")
                withAnimation(.interactiveSpring(duration: 0.5)) {
                    scale = handleScaleChange(value.magnification)
                }
            })
            .onEnded { _ in
                lastScale = scale
            }
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged({ value in
                withAnimation(.interactiveSpring()) {
                    offset.width = handleScaleChange(value.translation.width)
                    offset.height = handleScaleChange(value.translation.height)
                }
            })
            .onEnded({ value in
                
            })
    }
    
    private func handleScaleChange(_ zoom: CGFloat) -> CGFloat {
        lastScale + zoom - (lastScale == 0 ? 0 : 1)
    }
    
    private func handleOffsetChange(_ offset: CGSize) -> CGSize {
        var newOffset: CGSize = .zero
        
        newOffset.width = offset.width + lastOffset.width
        newOffset.height = offset.height + lastOffset.height
        
        return newOffset
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationStack(path: $path) {
                VStack {
                    
                    Image(uiImage: picture)
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height/2)
                        .offset(x: offset.width, y: offset.height)
                        .scaleEffect(scale)
                    
                    Spacer()
                    
                    VStack {
                        PhotosPicker(selection: $selected, matching: .images, photoLibrary: .shared()) { Text("Select a photo") }
                            .interactiveDismissDisabled()
                            .photosPickerStyle(.inline)
                            .photosPickerDisabledCapabilities(.sensitivityAnalysisIntervention)
                            .photosPickerAccessoryVisibility(.hidden)
                    }
                }
                .onAppear(perform: {
                    loadFirstPhoto()
                })
                .onChange(of: selected, initial: false) { old, item in
                    Task(priority: .background) {
                        if let data = try? await item?.loadTransferable(type: Data.self) {
                            resetScale()
                            picture = UIImage(data: data)!
                        }
                    }
                }
                .navigationTitle("새 게시물")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            PostingView(selected: $picture, path: $path)
                        } label: {
                            Text("다음")
                        }
                        
                    }
                }
            }
            
        })
        .onAppear(perform: {
            print("hi")
        })
    }
}


#Preview {
    SelectingImage(path: .constant(["1","2"]))
}
//import SwiftUI
//import PhotosUI
//import CoreTransferable
//
//
//struct SelectingImage: View {
//
//    @Environment(\.dismiss) var dismiss
//    @State private var selected: PhotosPickerItem?
//    @State private var firstPhoto: UIImage?
//    @State private var picture: UIImage = UIImage(named: "nopicture")!
//    @State private var modal = true
//    @State private var offset: CGSize = .zero
//    @State var lastOffset: CGSize = .zero
//    @State private var scale: CGFloat = 1.0
//    @State private var lastScale: CGFloat = 1.0
//    @State private var imageOffset: CGSize = .zero
//    @GestureState private var magnifyBy = 1.0
//
//    var magnification: some Gesture {
//        MagnifyGesture(minimumScaleDelta: 0)
//            .onChanged({ value in
//                print("확대")
//                withAnimation(.interactiveSpring()) {
//                    if value.magnification < 1.0 {
//                        self.scale = 1.0
//                    } else {
//                        scale = handleScaleChange(value.magnification)
//                    }
//                }
//            })
//            .onEnded { _ in
//                lastScale = scale
//            }
//    }
//
//    var drag: some Gesture {
//        DragGesture()
//            .onChanged({ value in
//                print("드래그")
//                withAnimation(.interactiveSpring()) {
//                    offset.width = min(max(handleOffsetChange(value.translation).width, -imageOffset.width), imageOffset.width)
//                    offset.height = min(max(handleOffsetChange(value.translation).height, -imageOffset.height), imageOffset.height)
////                    offset = handleOffsetChange(value.translation)
//                }
//            })
//            .onEnded({ value in
//                lastOffset = offset
//            })
//    }
//
//    //MARK: FUNC
//
//    func loadFirstPhoto() {
//        // 앨범에서 이미지 가져오기
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//
//        if let firstAsset = result.firstObject {
//            let imageManager = PHImageManager.default()
//            let targetSize = CGSize(width: 1000, height: 1000)
//
//            imageManager.requestImage(for: firstAsset,
//                                      targetSize: targetSize,
//                                      contentMode: .aspectFill,
//                                      options: nil) { (image, _) in
//                if let image = image {
//                    // 이미지를 가져왔을 때
//                    picture = image
//                } else {
//                    // 이미지를 가져오는 데 실패했을 때
//                    print("Failed to load image")
//                }
//            }
//        } else {
//            // 앨범에 이미지가 없을 때
//            print("No images found in the album")
//        }
//    }
//
//    private func handleScaleChange(_ zoom: CGFloat) -> CGFloat {
//        lastScale + zoom - (lastScale == 0 ? 0 : 1)
//    }
//
//    private func handleOffsetChange(_ offset: CGSize) -> CGSize {
//        var newOffset: CGSize = .zero
//
//        newOffset.width = offset.width + lastOffset.width
//        newOffset.height = offset.height + lastOffset.height
//
//        return newOffset
//    }
//
//    func resetScale() {
//        print("초기화")
//        scale = 1.0
//        offset = .zero
//        lastScale = .zero
//        lastOffset = .zero
//        imageOffset = .zero
//    }
//
//
//
//    var body: some View {
//
//        VStack {
//            GeometryReader(content: { geometry in
//                Image(uiImage: picture)
//                    .resizable()
//                    .scaledToFit()
//                    .offset(x: imageOffset.width, y: imageOffset.height)
//                    .scaleEffect(scale)
//                    .gesture(SimultaneousGesture(drag, magnification))
////                    .onAppear(perform: {
////                        imageOffset.width = geometry.size.width// / 3
////                        imageOffset.height = geometry.size.height// / 3
////                    })
//            })
//
//
//            Spacer()
//
//            VStack {
//                PhotosPicker(selection: $selected, matching: .images, photoLibrary: .shared()) { Text("Select a photo") }
//                    .interactiveDismissDisabled()
//                    .photosPickerStyle(.inline)
//                    .photosPickerDisabledCapabilities(.sensitivityAnalysisIntervention)
//                    .photosPickerAccessoryVisibility(.hidden)
//            }
//        }
//        .onAppear(perform: {
//            loadFirstPhoto()
//        })
//        .onChange(of: selected, initial: false) { old, item in
//            Task(priority: .background) {
//                if let data = try? await item?.loadTransferable(type: Data.self) {
//                    resetScale()
//                    picture = UIImage(data: data)!
//                }
//            }
//        }
//        .navigationTitle("새 게시물")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                NavigationLink {
//                    PostingView(selected: $picture)
//                } label: {
//                    Text("다음")
//                }
//
//            }
//        }
//    }
//}
//
//
//#Preview {
//    SelectingImage()
//}
