import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _autoRouteEnabled = true;
  bool _shareDataEnabled = false;
  String _selectedMapStyle = 'Standard';
  double _detectionRadius = 500.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section Profil & Points
          _buildSectionTitle('Mon Profil'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: const Text('Utilisateur Premium'),
                  subtitle: const Text('🏆 2,347 points'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showComingSoonDialog('Gestion du profil');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.stars, color: Colors.amber),
                  title: const Text('Mes Points'),
                  subtitle: const Text('Historique et récompenses'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showComingSoonDialog('Historique des points');
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section Navigation
          _buildSectionTitle('Navigation'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.route, color: Colors.green),
                  title: const Text('Évitement automatique'),
                  subtitle: const Text('Éviter automatiquement les caméras'),
                  value: _autoRouteEnabled,
                  onChanged: (value) {
                    setState(() {
                      _autoRouteEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.radar, color: Colors.orange),
                  title: const Text('Rayon de détection'),
                  subtitle: Text('${_detectionRadius.round()}m'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showRadiusDialog();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.map, color: Colors.blue),
                  title: const Text('Style de carte'),
                  subtitle: Text(_selectedMapStyle),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showMapStyleDialog();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Section Caméras
          _buildSectionTitle('Caméras'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.red),
                  title: const Text('Ajouter une caméra'),
                  subtitle: const Text('Signaler une nouvelle caméra (+10 pts)'),
                  trailing: const Icon(Icons.add_circle_outline),
                  onTap: () {
                    Navigator.pop(context); // Retour vers la caméra
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.purple),
                  title: const Text('Mes contributions'),
                  subtitle: const Text('Caméras ajoutées: 23'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showComingSoonDialog('Historique des contributions');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.report, color: Colors.orange),
                  title: const Text('Signaler une erreur'),
                  subtitle: const Text('Caméra supprimée ou déplacée'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showComingSoonDialog('Signalement d\'erreur');
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Section Notifications
          _buildSectionTitle('Notifications'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications, color: Colors.blue),
                  title: const Text('Notifications'),
                  subtitle: const Text('Alertes de caméras à proximité'),
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up, color: Colors.green),
                  title: const Text('Son'),
                  subtitle: const Text('Alertes sonores'),
                  value: _soundEnabled,
                  onChanged: _notificationsEnabled ? (value) {
                    setState(() {
                      _soundEnabled = value;
                    });
                  } : null,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.vibration, color: Colors.orange),
                  title: const Text('Vibration'),
                  subtitle: const Text('Alertes par vibration'),
                  value: _vibrationEnabled,
                  onChanged: _notificationsEnabled ? (value) {
                    setState(() {
                      _vibrationEnabled = value;
                    });
                  } : null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Section Confidentialité
          _buildSectionTitle('Confidentialité'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.share, color: Colors.blue),
                  title: const Text('Partage de données'),
                  subtitle: const Text('Aider à améliorer l\'application'),
                  value: _shareDataEnabled,
                  onChanged: (value) {
                    setState(() {
                      _shareDataEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.green),
                  title: const Text('Politique de confidentialité'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showComingSoonDialog('Politique de confidentialité');
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Section Support
          _buildSectionTitle('Support'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.help, color: Colors.blue),
                  title: const Text('Aide'),
                  subtitle: const Text('FAQ et guides d\'utilisation'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showComingSoonDialog('Page d\'aide');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.feedback, color: Colors.orange),
                  title: const Text('Nous contacter'),
                  subtitle: const Text('Suggestions et support'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showComingSoonDialog('Formulaire de contact');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.grey),
                  title: const Text('À propos'),
                  subtitle: const Text('SafeRoute v1.0.0'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showAboutDialog();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Bouton de déconnexion
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                _showLogoutDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Se déconnecter',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bientôt disponible'),
        content: Text('$feature sera disponible dans une prochaine mise à jour.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showRadiusDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rayon de détection'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Distance: ${_detectionRadius.round()}m'),
            Slider(
              value: _detectionRadius,
              min: 100,
              max: 2000,
              divisions: 19,
              onChanged: (value) {
                setState(() {
                  _detectionRadius = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showMapStyleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Style de carte'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Standard', 'Satellite', 'Terrain', 'Hybride']
              .map((style) => RadioListTile<String>(
                    title: Text(style),
                    value: style,
                    groupValue: _selectedMapStyle,
                    onChanged: (value) {
                      setState(() {
                        _selectedMapStyle = value!;
                      });
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('À propos de SafeRoute'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SafeRoute v1.0.0'),
            SizedBox(height: 10),
            Text('Application collaborative pour éviter les caméras de surveillance.'),
            SizedBox(height: 10),
            Text('Développé avec ❤️ par l\'équipe SafeRoute'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Logique de déconnexion ici
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Déconnexion effectuée'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Déconnecter'),
          ),
        ],
      ),
    );
  }
}