import React from 'react';
import styles from './badge.module.css';

export const Badge = ({ variant, className, ...props }) => {
  const variantClass = styles[variant] || styles.default;
  return (
    <span className={`${styles.badge} ${variantClass} ${className ?? ''}`} {...props} />
  );
};