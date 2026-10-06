//
//  ViewController.swift
//  apple_lab08_pract02_UIKit
//
//  Created by Jeferson Huittoccollo on 6/10/26.
//

import UIKit

// Modelo de datos para el docente
struct Teacher {
    let name: String
    let department: String
    let initials: String
}

class TeacherController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    // Conexión Outlet para vincular con el Storyboard
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // Lista de al menos 8 docentes
    let teachers: [Teacher] = [
        Teacher(name: "John Doe", department: "Mathematics", initials: "JD"),
        Teacher(name: "Anna Smith", department: "Physics", initials: "AS"),
        Teacher(name: "Robert Johnson", department: "Chemistry", initials: "RJ"),
        Teacher(name: "Maria Brown", department: "Biology", initials: "MB"),
        Teacher(name: "David Wilson", department: "History", initials: "DW"),
        Teacher(name: "Emily Garcia", department: "English", initials: "EG"),
        Teacher(name: "Thomas Martinez", department: "Computer Science", initials: "TM"),
        Teacher(name: "Laura Taylor", department: "Art", initials: "LT")
    ]
    
    var filteredTeachers: [Teacher] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar delegados y registrar celda
        if tableView != nil {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(TeacherCell.self, forCellReuseIdentifier: "TeacherCell")
        }
        
        setupSearchController()
        filteredTeachers = teachers
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTeachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell", for: indexPath) as? TeacherCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredTeachers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    // MARK: - UISearchResultsUpdating (Buscador)
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            filteredTeachers = teachers
            tableView?.reloadData()
            return
        }
        
        filteredTeachers = teachers.filter {
            $0.name.lowercased().contains(text.lowercased()) ||
            $0.department.lowercased().contains(text.lowercased())
        }
        tableView?.reloadData()
    }
}

// MARK: - Celda Personalizada con Iniciales Circulares
class TeacherCell: UITableViewCell {
    
    let avatarLabel = UILabel()
    let nameLabel = UILabel()
    let departmentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarLabel.textAlignment = .center
        avatarLabel.font = .boldSystemFont(ofSize: 16)
        avatarLabel.textColor = .systemBlue
        avatarLabel.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        avatarLabel.layer.cornerRadius = 22
        avatarLabel.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .boldSystemFont(ofSize: 16)
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentLabel.font = .systemFont(ofSize: 14)
        departmentLabel.textColor = .systemGray
        
        let labelStack = UIStackView(arrangedSubviews: [nameLabel, departmentLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 2
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(avatarLabel)
        contentView.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            avatarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarLabel.widthAnchor.constraint(equalToConstant: 44),
            avatarLabel.heightAnchor.constraint(equalToConstant: 44),
            
            labelStack.leadingAnchor.constraint(equalTo: avatarLabel.trailingAnchor, constant: 12),
            labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with teacher: Teacher) {
            avatarLabel.text = teacher.initials
            nameLabel.text = teacher.name
            departmentLabel.text = teacher.department
            
            // Colores personalizados dinámicos para los círculos
            let colors: [UIColor] = [
                .systemBlue,
                .systemOrange,
                .systemGreen,
                .systemPurple,
                .systemRed,
                .systemPink,
                .systemTeal,
                .systemYellow
            ]
            
            // Seleccionar un color basado en las iniciales para mantener consistencia
            let colorIndex = abs(teacher.initials.hashValue) % colors.count
            let selectedColor = colors[colorIndex]
            
            avatarLabel.textColor = selectedColor
            avatarLabel.backgroundColor = selectedColor.withAlphaComponent(0.15)
        }
}

