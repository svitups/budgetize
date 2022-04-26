import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine

class AccountViewModel: ObservableObject{
    @Published var accounts = [Account]()
    
    private let path: String = "accounts"
    private let store = Firestore.firestore()
    
    private var userId = ""
    
    init () {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
            self.getAccounts()
        }
    }
    
    var accountId = ""
    
    func createAccount(_ account: Account) {
        do {
            var newAccount = account
            newAccount.id = accountId
        }
        
    }
    
    func getAccounts() {
        store.collection("accounts")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
            guard let accounts = querySnapshot?.documents else {
                print("No accounts")
                return
            }
            
            self.accounts = accounts.compactMap { (queryDocumentSnapshot) -> Account? in
                return try! queryDocumentSnapshot.data(as: Account.self)
            }
        }
    }
    
    func editAccount() {
        
    }
    func deleteAccount() {
        
    }
    
    func showAllAccounts() {
        
    }
    
}
