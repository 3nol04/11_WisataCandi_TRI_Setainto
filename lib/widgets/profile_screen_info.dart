import 'package:flutter/material.dart';

class ProfileItemInfo extends StatelessWidget {
  const ProfileItemInfo({super.key,
  required this.icon,
  required this.label,
  required this.value,
  this.showEditIcon = false,
  this.onEditPressed,
  required this.iconColor});

  final IconData icon;
  final String label, value;
  final bool showEditIcon;
  final VoidCallback? onEditPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3 ,
          child: Row(
            children: [
              Icon(icon , color: iconColor,),
              const SizedBox(width: 8,),
              Text(label,
              style: const TextStyle( fontSize: 16,fontWeight: FontWeight.bold),),
                          
            ],
          ),
        ),
        Expanded(child: Text(' :$value',
        style: const TextStyle( fontSize: 18),)),
        if(showEditIcon)
         InkWell(
           onTap: onEditPressed,
           child: const Icon(Icons.edit),
         )
      ],
    );
  }
}