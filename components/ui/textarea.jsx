import React from 'react';
import styles from './textarea.module.css';

export const Textarea = ({ className, ...props }) => {
  return (
    <textarea
      className={`${styles.textarea} ${className ?? ''}`}
      {...props}
    />
  );
};