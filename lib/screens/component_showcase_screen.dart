import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class ComponentShowcaseScreen extends StatefulWidget {
  const ComponentShowcaseScreen({Key? key}) : super(key: key);

  @override
  State<ComponentShowcaseScreen> createState() => _ComponentShowcaseScreenState();
}

class _ComponentShowcaseScreenState extends State<ComponentShowcaseScreen> {
  bool isPasswordVisible = false;
  String inputValue = '';
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.lightNeutral100,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        title: Text(
          'Component Showcase',
          style: AppTheme.h3,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.053),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Fields Section
            _buildSectionTitle('Input Fields'),
            const SizedBox(height: 16),
            
            CustomInputField(
              label: 'Label',
              placeholder: 'Input goes in here',
              onChanged: (value) {
                setState(() {
                  inputValue = value;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            CustomInputField(
              label: 'Label',
              placeholder: 'Input goes in here',
              isPassword: true,
              isPasswordVisible: isPasswordVisible,
              onToggleVisibility: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              onChanged: (value) {},
            ),
            
            const SizedBox(height: 32),
            
            // Button Section
            _buildSectionTitle('Buttons'),
            const SizedBox(height: 16),
            
            CustomButton(
              text: 'Call to action goes here',
              onPressed: () {},
              size: ButtonSize.large,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton(
              text: 'Call to action goes here',
              onPressed: () {},
              size: ButtonSize.medium,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton(
              text: 'Call to action goes here',
              onPressed: () {},
              size: ButtonSize.small,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton(
              text: 'Call to action goes here',
              onPressed: () {},
              size: ButtonSize.small,
              hasDropdown: true,
            ),
            
            const SizedBox(height: 12),
            
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.053),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryPurple,
                  side: const BorderSide(color: AppTheme.primaryPurple, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_circle_outline, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Call to action goes here',
                      style: AppTheme.pStrong.copyWith(
                        color: AppTheme.primaryPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Elevation Examples
            _buildSectionTitle('Elevation Styles'),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppTheme.elevation9,
                    ),
                    child: Center(
                      child: Text(
                        'Elevation 9% blur',
                        style: AppTheme.h5Strong,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppTheme.elevation17,
                    ),
                    child: Center(
                      child: Text(
                        'Elevation 17% blur',
                        style: AppTheme.h5Strong,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Tab Section
            _buildSectionTitle('Tabs'),
            const SizedBox(height: 16),
            
            Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.lightNeutral200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTab('Active tab title', 0, true),
                  ),
                  Expanded(
                    child: _buildTab('Inactive tab title', 1, false),
                  ),
                  Expanded(
                    child: _buildTabWithBadge('Coming soon tab', 2, false),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Tile Section
            _buildSectionTitle('Tiles'),
            const SizedBox(height: 16),
            
            _buildTile('Contract performance', false),
            
            const SizedBox(height: 12),
            
            _buildTile('Contract performance', true),
            
            const SizedBox(height: 32),
            
            // Dropdown Section
            _buildSectionTitle('Dropdown'),
            const SizedBox(height: 16),
            
            _buildDropdown('Label'),
            
            const SizedBox(height: 32),
            
            // Color Palette
            _buildSectionTitle('Color Palette'),
            const SizedBox(height: 16),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildColorSwatch('White', AppTheme.white),
                _buildColorSwatch('Light 100', AppTheme.lightNeutral100),
                _buildColorSwatch('Light 200', AppTheme.lightNeutral200),
                _buildColorSwatch('Gray', AppTheme.gray),
                _buildColorSwatch('Black', AppTheme.black),
                _buildColorSwatch('Blue 100', AppTheme.blue100),
                _buildColorSwatch('Blue 300', AppTheme.blue300),
                _buildColorSwatch('Blue 500', AppTheme.blue500),
                _buildColorSwatch('Blue 700', AppTheme.blue700),
                _buildColorSwatch('Blue 900', AppTheme.blue900),
                _buildColorSwatch('Red 300', AppTheme.red300),
                _buildColorSwatch('Red 700', AppTheme.red700),
                _buildColorSwatch('Red 900', AppTheme.red900),
                _buildColorSwatch('Yellow 600', AppTheme.yellow600),
                _buildColorSwatch('Purple 100', AppTheme.purple100),
                _buildColorSwatch('Purple 700', AppTheme.purple700),
                _buildColorSwatch('Purple 900', AppTheme.purple900),
                _buildColorSwatch('Green 100', AppTheme.green100),
                _buildColorSwatch('Green 500', AppTheme.green500),
                _buildColorSwatch('Green 700', AppTheme.green700),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTheme.h3,
    );
  }

  Widget _buildTab(String title, int index, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppTheme.primaryPurple : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: AppTheme.h5Strong.copyWith(
            color: isActive ? AppTheme.primaryPurple : AppTheme.gray,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTabWithBadge(String title, int index, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppTheme.primaryPurple : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTheme.h5Strong.copyWith(
                color: isActive ? AppTheme.primaryPurple : AppTheme.gray,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Coming Soon',
                style: AppTheme.minimal.copyWith(
                  color: AppTheme.green700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(String title, bool hasComingSoon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.lightNeutral200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.description_outlined,
            size: 40,
            color: AppTheme.primaryPurple,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTheme.h5Strong,
          ),
          if (hasComingSoon) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Coming Soon',
                style: AppTheme.pStrong.copyWith(
                  color: AppTheme.green700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            label,
            style: AppTheme.inputLabel,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.lightNeutral200),
          ),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            hint: Text(
              'Label',
              style: AppTheme.h5Light.copyWith(color: AppTheme.gray),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.gray),
            items: ['Option 1', 'Option 2', 'Option 3'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: AppTheme.h5Strong),
              );
            }).toList(),
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildColorSwatch(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.lightNeutral200),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: AppTheme.minimal,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
