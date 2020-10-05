import SwiftUI

struct ContentView: View {
    @State var isShow = false
    @State var imageData : Data = Data(count: 1)
    var body: some View {
        VStack{
            Button(action: {
                isShow.toggle()
            }, label: {
                Text("Picker image")
            })
        }.fullScreenCover(isPresented: $isShow, onDismiss: {}, content: {
            ImagePicker(imagePicker: $isShow, imageData: $imageData)
        })
        
        
    }
}

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var imagePicker : Bool
    @Binding var imageData : Data
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent : ImagePicker
        init(parent : ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            parent.imageData = image.jpegData(compressionQuality: 0.5)!
            parent.imagePicker.toggle()
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.imagePicker.toggle()
        }
    }
    
    
}

  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
