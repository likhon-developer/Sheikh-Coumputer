import React from 'react';
import styles from './card.module.css';

export const Card = ({ className, ...props }) => (
  <div className={`${styles.card} ${className ?? ''}`} {...props} />
);

export const CardHeader = ({ className, ...props }) => (
  <div className={`${styles.cardHeader} ${className ?? ''}`} {...props} />
);

export const CardTitle = ({ className, ...props }) => (
  <h3 className={`${styles.cardTitle} ${className ?? ''}`} {...props} />
);

export const CardDescription = ({ className, ...props }) => (
  <p className={`${styles.cardDescription} ${className ?? ''}`} {...props} />
);

export const CardContent = ({ className, ...props }) => (
  <div className={`${styles.cardContent} ${className ?? ''}`} {...props} />
);

export const CardFooter = ({ className, ...props }) => (
  <div className={`${styles.cardFooter} ${className ?? ''}`} {...props} />
);